import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/pages/student/student_home_page.dart';

import '../../common/formatter.dart';
import '../../utils/show_snackbar.dart';

class AddStudentNumberPage extends StatelessWidget {
  AddStudentNumberPage({Key? key, required this.docId}) : super(key: key);
  final TextEditingController _studentNumberController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: _studentNumberController,
                decoration: const InputDecoration(
                    labelText: 'Student Number',
                    hintText: 'Enter Student Number ...',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey)),
                    // when the field is in focus
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black)),
                    isDense: true,
                    contentPadding: EdgeInsets.all(20) // Added this
                    ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Student Number cannot be empty';
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced)
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String studentNumber = _studentNumberController.text;
                    addStudentNumber(
                        docId: docId,
                        studentNumber: studentNumber
                    ).then((value) {
                      return Navigator.popAndPushNamed(
                          context, StudentHomePage.routeName);
                    });
                    showSnackBar(context, 'Ticket has been sent successfully');
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 25)),
                child: const Text('Submit')),
          )
        ],
      ),
    );
  }
}

Future addStudentNumber({required docId, required studentNumber}) async {
  final docTicket = FirebaseFirestore.instance.collection('users').doc(docId);
  docTicket.update({'studentNumber': studentNumber});
}
