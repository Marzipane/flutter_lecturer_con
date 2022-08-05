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

  LecturerHomePage({Key? key}) : super(key: key);
  List list = [];

  @override
  Widget build(BuildContext context) {
    setPageTitle('Lecturer | Home', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().user(user: user, context: context, title: 'Lecturer Home Page', auth: auth),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Ticket>>(
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
      ),
    );
  }

  Stream<List<Ticket>> readTickets({required user}) {
    return FirebaseFirestore.instance
        .collection('tickets')
        .where('receiver', isEqualTo: user.uid)
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
          Divider(),
          SizedBox(
            height: 5,
          ),
          Text('Title: ${ticket.title}', style: TextStyle(fontSize: 18),),
          Text(ticket.status.toString()),
          SizedBox(
            height: 5,
          ),
          Center(
            child: ReplyButton(ticket: ticket),
          ),
        ]),
    );
  }
}

class ReplyButton extends StatelessWidget {
  const ReplyButton({Key? key, required this.ticket}) : super(key: key);
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ReplyTicketPage.routeName,
              arguments: {'ticket': ticket});
        },
        child: const Text('Answer'));
  }
}
