import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/users_instance_model.dart';
import '../../pages/student/add_ticket_page.dart';

class StudentHomePage extends StatelessWidget {
  static const routeName = '/student-home-page';
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.abc_rounded),
          onPressed: () => debugPrint(readTeachers().toString()),
        ),
      ),
      body: StreamBuilder<List<UserInstance>>(
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
                child: ListView(
                  children: teachers.map(buildTeacher).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildTeacher(UserInstance teacher) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(30.0)),
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
          debugPrint(teacher.email.toString());
          Navigator.popAndPushNamed(context, AddTicketPage.routeName,
              arguments: {'teacher': teacher});
        },
        child: const Text('Ask'));
  }
}
