import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/common/smtp.dart';
import 'package:flutter_lecon/pages/student/tickets_list_page.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/app_theme.dart';
import '../../common/set_page_title.dart';
import '../../models/users_instance_model.dart';
import '../../pages/student/add_ticket_page.dart';
import '../../services/firebase_auth_methods.dart';
import '../general/add_user_data_page.dart';
import '../lecturer/lecturer_home_page.dart';

// class StudentHomePage extends StatefulWidget {
//   static const routeName = '/student-home-page';
//
//   StudentHomePage({Key? key, this.data}) : super(key: key);
//   final data;
//
//   @override
//   State<StudentHomePage> createState() => _StudentHomePageState();
// }

class StudentHomePage extends StatelessWidget {
  static const routeName = '/student-home-page';
  final formKey = GlobalKey<FormState>();
  StudentHomePage({Key? key, this.data}) : super(key: key);
  final data;

  final TextEditingController _passwordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | Ask ${data['password']}', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtStudentAppBar(
          user: user, context: context, title: 'Ask', auth: auth),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            StreamBuilder<List<UserInstance>>(
              stream: readTeachers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                if (snapshot.hasData) {
                  final teachers = snapshot.data!;

                  return Center(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: teachers.map(buildTeacher).toList(),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeacher(UserInstance teacher) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(23.0)),
      child: ListTile(
          leading: Text(teacher.email!),
          trailing: MyButton(
            teacher: teacher,
            password: data['password'],
            formKey: formKey,
            controller: _passwordCheckController,
          )),
    );
  }

  Stream<List<UserInstance>> readTeachers() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('isLecturer', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserInstance.fromJson(doc.data()))
            .toList());
  }
}

// class MyButton extends StatefulWidget {
//   MyButton(
//       {Key? key,
//       required this.teacher,
//       required this.password,
//       required this.formKey,
//       required this.controller})
//       : super(key: key);
//   final UserInstance teacher;
//   String password;
//   final formKey;
//   TextEditingController controller;
//
//   @override
//   State<MyButton> createState() => _MyButtonState();
// }

class MyButton extends StatelessWidget {
  MyButton(
     {Key? key,
      required this.teacher,
      required this.password,
     required this.formKey,
      required this.controller})
      : super(key: key);
  final UserInstance teacher;
  String password;
  final formKey;
  TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final firebaseUser = context.watch<User?>();
    return ElevatedButton(
        onPressed: () {
          buildPasswordConfirmation(context);
        },
        child: const Text('Ask'));
  }

  Future<dynamic> buildPasswordConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Password Confirmation'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Password ${password}',
              hintText: 'Password ...',
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.grey)),
              // when the field is in focus
              focusedBorder: const OutlineInputBorder(
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
          TextButton(onPressed: () {
            if(formKey.currentState!.validate()){
              Navigator.popAndPushNamed(context, AddTicketPage.routeName,
                  arguments: {'teacher': teacher});
            }
          }, child: Text('Confirm')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'))
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
