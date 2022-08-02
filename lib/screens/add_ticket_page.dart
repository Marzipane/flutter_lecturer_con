import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lecon/screens/login_page.dart';
import 'package:flutter_lecon/screens/student_profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../common/formatter.dart';
import '../services/firebase_auth_methods.dart';
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: teacher.email,
                    hintText: 'Enter title ...',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter Description ...',
                  ),
                ),
                TextFormField(),
                const SizedBox(
                  height: 20,
                ),
                Text(user.uid),
                ElevatedButton(
                    onPressed: () {
                      String title = _titleController.text;
                      String desc = _descController.text;
                      sendTicket(
                              title: title,
                              desc: desc,
                              uid: user.uid,
                              teacherUid: teacher.uid)
                          .then((value) {
                        return Navigator.popAndPushNamed(
                            context, StudentHomePage.routeName);
                      });
                    },
                    child: Text(user.uid))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendTicket(
      {required String title,
      required desc,
      required uid,
      required teacherUid}) async {
    final docTicket = FirebaseFirestore.instance.collection('tickets').doc();
    // TODO: change uid to TEACHER UID
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

class Ticket{
  Ticket({
    required this.title,
    required this.description,
    required this.id,
    required this.studentUid,
    required this.teacherUid,
    this.status = "NR",
    this.reply,
  });
  final String? id;
  final String? title;
  final String? description;
  final String? studentUid;
  final String? teacherUid;
  final String? status;
  final String? reply;



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      "creator": studentUid,
      "receiver": teacherUid,
      "status": Formatters().formatStatus(status!),
      "reply": reply ?? ""
    };
  }

  static Ticket fromJson(Map<String, dynamic> json) {
    return Ticket(
        title: json['title'],
        studentUid: json['creator'],
        teacherUid: json['receiver'],
        status: json['status'],
        id: json['id'],
        reply: json['reply'],
        description: json['description']);
  }
}




// TODO: TO WHOM IT'S BEEN SENT;
