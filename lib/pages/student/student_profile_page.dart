import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/general/login_page.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../pages/student/add_ticket_page.dart';
import '../../widgets/custom_button.dart';

class StudentProfilePage extends StatelessWidget {
  static const routeName = '/student-profile-page';
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile Page'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.plus),
          onPressed: () {
            Navigator.pushNamed(context, AddTicketPage.routeName);
          },
        ),
      ),
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