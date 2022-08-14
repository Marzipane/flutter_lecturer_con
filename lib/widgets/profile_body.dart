import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/lecturer/firbase_read.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  final TextEditingController _urlController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return SingleChildScrollView(
      child: Column(
        children: [
          buildProfileStreamBuilder(
              user.uid, formKey, _urlController, firebaseUser),
        ],
      ),
    );
  }
}
