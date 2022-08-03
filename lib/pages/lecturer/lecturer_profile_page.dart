import 'package:flutter/material.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import '../general/login_page.dart';

class LecturerProfilePage extends StatelessWidget {
  static const routeName = '/lecturer-profile-page';
  const LecturerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(title: const Text('Lecturer Profile Page')),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 40),
          CircleAvatar(
            backgroundImage: Image.network(user.photoURL ??
                    'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png')
                .image,
            radius: 100,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(user.displayName ?? ''),
          Text(user.email ?? ''),
          Text(user.uid),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 300,
            child: CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context).then(
                    (value) => Navigator.popAndPushNamed(
                        context, LoginPage.routeName));
              },
              text: 'Sign Out',
              icon: FontAwesomeIcons.rightFromBracket,
              iconColor: Colors.red,
            ),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}