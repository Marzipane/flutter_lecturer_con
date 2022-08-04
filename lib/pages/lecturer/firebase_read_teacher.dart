import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildTeacherStreamBuilder(teacherUid) {
  return StreamBuilder<List>(
    stream: getTeacher(uid: teacherUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
            children:
                users.map((user) => Text('From: ${user.email}')).toList());
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Stream<List> getTeacher({required uid}) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserInstance.fromJson(doc.data()))
          .toList());
}
