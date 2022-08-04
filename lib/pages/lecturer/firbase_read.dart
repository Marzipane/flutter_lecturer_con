import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildStreamBuilder(studentUid) {
  return StreamBuilder<List>(
    stream: getStudent(uid: studentUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
          children: users
              .map((user) => Text(
                    'From: ${user.email}',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic  ),
                  ))
              .toList(),
        );
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Stream<List> getStudent({required uid}) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserInstance.fromJson(doc.data()))
          .toList());
}
