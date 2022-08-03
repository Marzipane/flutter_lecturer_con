import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/users_instance_model.dart';

StreamBuilder<List> buildStreamBuilder(studentUid) {
  return StreamBuilder<List>(
    stream: getStudent(uid: studentUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Column(children:  users.map((user) => Text('${user.email}')).toList());}
      else {return CircularProgressIndicator();}
    },
  );
}



Stream<List> getStudent({required uid}) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => UserInstance.fromJson(doc.data())).toList());
}