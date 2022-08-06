import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildLecturerStreamBuilder(teacherUid) {
  return StreamBuilder<List<UserInstance>>(
    stream: getLecturer(uid: teacherUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: users
              .map((user) => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(user.displayName ?? 'Not found', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic  ),),
                        Row(
                          children: [
                            Text(
                              'To: ',
                              style: TextStyle(
                                fontSize: 16,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              '@${user.displayName}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
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

Stream<List<UserInstance>> getLecturer({required uid}) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserInstance.fromJson(doc.data()))
          .toList());
}
