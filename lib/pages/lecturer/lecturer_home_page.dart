import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/common/set_page_title.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/app_theme.dart';
import '../../models/ticket_model.dart';
import '../../services/firebase_auth_methods.dart';
import 'firbase_read.dart';
import 'reply_ticket_page.dart';



class LecturerHomePage extends StatelessWidget {
  static const routeName = '/lecturer-home-page';
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordCheckController =
  TextEditingController();

  LecturerHomePage({Key? key, this.data}) : super(key: key);
  List list = [];
  final data;

  @override
  Widget build(BuildContext context) {
    setPageTitle('Lecturer | Home', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtLecturerAppBar(user: user, context: context, title: 'Reply', auth: auth),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            StreamBuilder<List<Ticket>>(
              stream: readTickets(user: user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final tickets = snapshot.data!;
                  return Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.spaceAround,
                            runAlignment: WrapAlignment.center,
                            children: tickets
                                .map((ticket) =>
                                    buildTicket(ticket, ticket.studentUid))
                                .toList()),
                    ),
                  );
                } else {
                  return Center(child: Text(snapshot.toString()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<Ticket>> readTickets({required user}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('receiver', isEqualTo: user.uid)
        .where('status' , whereIn: ['Evaluated', 'Not read yet'])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
  }

  Widget buildTicket(Ticket ticket, studentUid) {
    return Container(
      width: 350,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20.0),
      decoration: AppBoxDecoration().all(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildStreamBuilder(studentUid),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Text('Title: ${ticket.title ?? 'Null'}', style: const TextStyle(fontSize: 18),),
          const SizedBox(height: 5,),
          Text('${ticket.status}', style: const TextStyle(fontSize: 12),),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: MyButton(
              ticket: ticket,
              password: data['password'],
              formKey: formKey,
              controller: _passwordCheckController,
            ),
          ),
        ]),
    );
  }
}
class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
        required this.ticket,
        required this.password,
        required this.formKey,
        required this.controller})
      : super(key: key);
  final Ticket ticket;
  final String password;
  final formKey;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          buildPasswordConfirmation(context);
        },
        child: const Text('Reply'));
  }

  Future<dynamic> buildPasswordConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Password Confirmation'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Password ...',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              // when the field is in focus
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black)),
              errorStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.ErrorRed,
              ),
              // when the field is not in focus
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(40),
            ],
            validator: (String? value) => _validatePassword(value),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',style: TextStyle(color: AppColors.ErrorRed))),
          TextButton(onPressed: () {
            if(formKey.currentState!.validate()){
              Navigator.pushNamedAndRemoveUntil(context, ReplyTicketPage.routeName,
                  arguments: {'ticket': ticket}, (route) => false);
            }
          }, child: const Text('Confirm',style: TextStyle(color: AppColors.Green))),
        ],
      ),
    );
  }

  _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    else if(value != password){
      return 'Incorrect password';
    }
    return null;
  }
}
