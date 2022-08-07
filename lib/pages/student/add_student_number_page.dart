import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/common/app_theme.dart';
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
      appBar: AppBar(),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Student Number',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 600,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: _studentNumberController,
                    maxLength: 9,
                    decoration: const InputDecoration(
                      labelText: 'Student Number',
                      hintText: 'Enter student number ...',
                      helperText: 'Format: ##17#####',
                      helperStyle: TextStyle(color: AppColors.White, fontSize: 13, fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      // when the field is in focus
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      isDense: true,
                      contentPadding: EdgeInsets.all(25),
                      errorStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent
                      ),
                    ),
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty || value == '') {
                        return 'Student Number cannot be empty';
                      }
                      else if(value.length != 9){
                        return 'Student Number must be exatcly of 9 digits';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        200,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      ),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String studentNumber = _studentNumberController.text;
                    addStudentNumber(docId: docId, studentNumber: studentNumber)
                        .then((value) {
                      return Navigator.popAndPushNamed(
                          context, StudentHomePage.routeName);
                    });
                    showSnackBar(context, 'Student number added successfully');
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 21, horizontal: 28)),
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
