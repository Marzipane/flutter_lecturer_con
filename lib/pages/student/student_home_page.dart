import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/smtp.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../models/users_instance_model.dart';
import '../../pages/student/add_ticket_page.dart';
import '../../services/firebase_auth_methods.dart';

class StudentHomePage extends StatelessWidget {
  static const routeName = '/student-home-page';
  const StudentHomePage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | Home', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().user(user: user, context: context, title: 'Home page', auth: auth),
      body: SingleChildScrollView(
        child: StreamBuilder<List<UserInstance>>(
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

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.teacher}) : super(key: key);
  final UserInstance teacher;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTicketPage.routeName,
              arguments: {'teacher': teacher});
        },
        child: const Text('Ask'));
  }
}


