import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/models/users_instance_model.dart';
import '../../common/set_page_title.dart';
import '../../common/smtp.dart';
import '../../common/text_data.dart';
import '../../utils/show_snackbar.dart';

class AddUserDataPage extends StatefulWidget {

  const AddUserDataPage({Key? key, required this.docId, required this.isLecturer, required this.user})
      : super(key: key);
  final String docId;
  final bool isLecturer;
  final user;

  @override
  State<AddUserDataPage> createState() => _AddUserDataPageState();
}

class _AddUserDataPageState extends State<AddUserDataPage> {
  bool _hidePass = true;

  final TextEditingController _studentNumberController =
      TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setPageTitle(
        widget.isLecturer ? 'Lecturer | Add data' : 'Student | Add data',
        context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Information'),
      ),
      body: SingleChildScrollView(
        child: !widget.isLecturer
            ? buildStudentForm(context)
            : buildLecturerForm(context),
      ),
    );
  }

  Column buildStudentForm(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Student information',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.network(
              'https://www.gau.edu.tr/storage//uploads/0/0/0/logotr-1580914525.png?vs=1',
              scale: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 600,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _studentNumberController,
                      maxLength: 9,
                      decoration: const InputDecoration(
                        labelText: 'Student Number',
                        hintText: 'Enter student number ...',
                        // helperText: 'Format: ##17#####',
                        icon: Icon(Icons.account_circle_rounded),
                        helperStyle: TextStyle(
                            color: AppColors.White,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        // when the field is in focus
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        // isDense: true,
                        // contentPadding: EdgeInsets.all(25),
                        errorStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ErrorRed,
                        ),
                      ),
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'Student Number cannot be empty';
                        } else if (value.length != 9) {
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePass,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password ...',
                        icon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(_hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        ),
                        // when the field is not in focus
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        // when the field is in focus
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ErrorRed,
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      validator: (String? value) => _validatePassword(value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String studentNumber = _studentNumberController.text;
                  String password = _passwordController.text;
                  addStudentData(
                    user: widget.user ,
                          docId: widget.docId,
                          studentNumber: studentNumber,
                          password: password)
                      .then((value) {
                    return Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  });
                  showSnackBar(context, 'Student has registered successfully');
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 28)),
              child: const Text('Submit')),
        )
      ],
    );
  }

  Column buildLecturerForm(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Lecturer information',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 600,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePass,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password ...',
                        icon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon: Icon(_hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        ),
                        // when the field is not in focus
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        // when the field is in focus
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.ErrorRed,
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      validator: (String? value) => _validatePassword(value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  String password = _passwordController.text;
                  addLecturerData(user: widget.user, docId: widget.docId, password: password)
                      .then((value) {
                    return Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  });
                  showSnackBar(context, 'Lecturer has registered successfully');
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 28)),
              child: const Text('Submit')),
        )
      ],
    );
  }
}

String? _validatePassword(String? value) {
  final RegExp passRegExp = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
  if (value!.isEmpty) {
    return 'Password is required';
  } else if (!passRegExp.hasMatch(value)) {
    return 'At least one capital letter, small letters, numbers.';
  }
  return null;
}


Future addStudentData(
    {required docId, required studentNumber, required password, required user}) async {
  final docTicket = FirebaseFirestore.instance.collection('users').doc(docId);
  docTicket.update({'studentNumber': studentNumber, 'password': password});
  sendSmtp(toEmail: user['email'] , text: AppText().smtpText(password: password, name: user['displayName']), subject: AppText.smtpSubject );
}

Future addLecturerData({required docId, required password, required user}) async {
  final docTicket = FirebaseFirestore.instance.collection('users').doc(docId);
  docTicket.update({'password': password});
  sendSmtp(toEmail: user['email'] , text: AppText().smtpText(password: password, name: user['displayName']), subject: AppText.smtpSubject );
}
