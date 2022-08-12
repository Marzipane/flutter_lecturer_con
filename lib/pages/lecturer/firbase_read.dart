import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/general/profile_page.dart';

import '../../common/app_theme.dart';
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
                        Image.network(
                          user.photoURL ?? 'Not found',
                          height: 200,
                        ),
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

StreamBuilder<List> buildProfileStreamBuilder(
    studentUid, formKey, TextEditingController urlController, firebaseUser) {
  return StreamBuilder<List<UserInstance>>(
    stream: getStudent(uid: studentUid),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final users = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: users
              .map(
                (user) => InkWell(
                  onHover: () {}(),
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // user can tap anywhere to close a dialog
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Change Avatar'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Enter a URL of an image'),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                width: 300,
                                child: Form(
                                    key: formKey,
                                    child: TextFormField(
                                      controller: urlController,
                                      decoration: InputDecoration(
                                        labelText: 'Image URL',
                                        hintText: 'Image URL ...',
                                        prefixIcon: Icon(Icons.image),
                                        // when the field is not in focus
                                        enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        // when the field is in focus
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        errorStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.ErrorRed,
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: AppColors.ErrorRed),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: AppColors.Green),
                              ),
                              onPressed: () {
                                updatePhotoURL(
                                    docId: user.uid,
                                    photoURL: urlController.text);
                                firebaseUser.updatePhotoURL(urlController.text);
                                urlController.text = '';
                                if (user.isLecturer) {
                                  Navigator.popAndPushNamed(
                                      context, LecturerProfilePage.routeName);
                                } else {
                                  Navigator.popAndPushNamed(
                                      context, StudentProfilePage.routeName);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.network(user.photoURL ??
                        'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png'),
                  ),
                ),
              )
              .toList(),
        );
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Future updatePhotoURL({required docId, required photoURL}) async {
  final docTicket = FirebaseFirestore.instance.collection('users').doc(docId);
  docTicket.update({'photoURL': photoURL});
}
