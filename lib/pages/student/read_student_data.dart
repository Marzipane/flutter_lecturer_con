import 'package:flutter/material.dart';
import '../../models/users_instance_model.dart';
import '../lecturer/firbase_read.dart';

StreamBuilder<List> buildStudentStreamBuilder(studentUid) {
  return StreamBuilder<List<UserInstance>>(
    stream: getStudent(uid: studentUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: users
              .map((user) =>
              Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  !user.isLecturer ?
                  Text(
                  'Student №: ${user.studentNumber ?? 'Not found'}',
                    style: TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic),
                  ): SizedBox.shrink(),
            ],
          ),
        ))
          .toList(),
      );
      } else {
      return const CircularProgressIndicator();
      }
    },
  );
}