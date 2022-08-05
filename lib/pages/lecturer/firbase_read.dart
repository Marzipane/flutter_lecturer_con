import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildStreamBuilder(studentUid) {
  return StreamBuilder<List>(
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
            Image.network(user.photoURL),
            Text('${user.displayName}', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic  ),),
            Text('${user.email}', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic  ),),
          ],),
              ))
              .toList()
          ,);
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
