// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../models/ticket_model.dart';
import '../../models/users_instance_model.dart';
import '../../services/firebase_auth_methods.dart';
import '../../utils/show_snackbar.dart';
import 'student_home_page.dart';

class AddTicketPage extends StatefulWidget {
  static const routeName = '/add-ticket-page';
  const AddTicketPage({Key? key}) : super(key: key);

  @override
  State<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int titleLength = 30;
  int descLength = 250;
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | Ticket', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final args = (ModalRoute.of(context)?.settings.arguments) as Map;
    final UserInstance teacher = args['teacher'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ticket'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 70),
          width: 500,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To: ${teacher.email}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _titleController,
                  maxLength: titleLength,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter title ...',
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
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '') {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(titleLength,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _descController,
                  maxLength: descLength,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description ...',
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
                    // isDense: true,
                    // contentPadding: EdgeInsets.all(20) // Added this
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == '') {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(descLength,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String title = _titleController.text;
                          String desc = _descController.text;
                          sendTicket(
                            title: title,
                            desc: desc,
                            uid: user.uid,
                            teacherUid: teacher.uid,
                          ).then((value) {
                            return Navigator.popAndPushNamed(
                                context, StudentHomePage.routeName);
                          });
                          showSnackBar(
                              context, 'Ticket has been sent successfully');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 25)),
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendTicket({
    required String title,
    required desc,
    required uid,
    required teacherUid,
  }) async {
    final docTicket = FirebaseFirestore.instance.collection('tickets').doc();
    final ticket = Ticket(
      title: title,
      description: desc,
      id: docTicket.id,
      studentUid: uid,
      teacherUid: teacherUid,
    );
    final json = ticket.toJson();
    await docTicket.set(json);
  }
}






// TODO: TO WHOM IT'S BEEN SENT;
