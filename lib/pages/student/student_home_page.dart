import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/app_theme.dart';
import '../../common/set_page_title.dart';
import '../../models/users_instance_model.dart';
import '../../pages/student/add_ticket_page.dart';
import '../../services/firebase_auth_methods.dart';

class StudentHomePage extends StatelessWidget {
  static const routeName = '/student-home-page';
  final formKey = GlobalKey<FormState>();

  StudentHomePage({Key? key, this.data}) : super(key: key);
  final data;

  final TextEditingController _passwordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | Ask', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtStudentAppBar(
          user: user, context: context, title: 'Ask', auth: auth),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
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
      width: 400,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(teacher.photoURL!, height: 225, width: 200),
                const SizedBox(
                  height: 10,
                ),
                Text(teacher.displayName!),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  teacher.email!,
                  style: const TextStyle(color: AppColors.LightGold, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                  teacher: teacher,
                  password: data['password'],
                  formKey: formKey,
                  controller: _passwordCheckController,
                ),
              ],
            ),
          ],
        ),
      ),
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

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.teacher,
      required this.password,
      required this.formKey,
      required this.controller})
      : super(key: key);
  final UserInstance teacher;
  final String password;
  final formKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Password Confirmation'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password ',
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
              child:
                  const Text('Cancel', style: TextStyle(color: AppColors.ErrorRed))),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.popAndPushNamed(
                    context,
                    AddTicketPage.routeName,
                    arguments: {'teacher': teacher},
                  );
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: AppColors.Green),
              )),
        ],
      ),
    );
  }

  _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value != password) {
      return 'Incorrect password';
    }
    return null;
  }
}
