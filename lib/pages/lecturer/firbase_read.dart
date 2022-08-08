import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildStreamBuilder(studentUid) {
  return StreamBuilder<List<UserInstance>>(
    stream: getStudent(uid: studentUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: users
              .map((user) => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.network(user.photoURL! ?? 'Not found'),
                        Text(
                          user.displayName ?? 'Not found',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                        Text(
                          user.email ?? 'Not found',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
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

Stream<List<UserInstance>> getStudent({required uid}) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserInstance.fromJson(doc.data()))
          .toList());
}
