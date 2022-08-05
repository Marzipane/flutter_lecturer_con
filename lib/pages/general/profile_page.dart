import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-page';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();

    return Scaffold(
      appBar: AppBars().user(user: user, context: context, title: 'Profile page', auth: auth),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 40),
            Image.network(user.photoURL ??
                    'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png'),
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
              iconColor: AppColors.LightRed,

            ),
          ),
          const SizedBox(height: 10),
        ]),
      ),
      backgroundColor: AppColors.LightSilver,
    );
  }
}
