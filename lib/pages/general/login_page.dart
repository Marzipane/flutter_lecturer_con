import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../services/firebase_auth_methods.dart';
import '../../widgets/google_login_button.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login-page';
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setPageTitle('Login', context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign-in'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Text(
                'Welcome back to our portal!',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.network('https://media-exp1.licdn.com/dms/image/C4E1BAQHU5VxhUd4i7w/company-background_10000/0/1621519446842?e=2147483647&v=beta&t=ydPmm12KrnOWaMYrFVuYrzFPzzRASwGDvRS-N7o2BK8',
                scale: 1.8, colorBlendMode: BlendMode.xor),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 300,
                child: GoogleLoginButton(
                  onTap: () {
                    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                  },
                  text: 'Sign in using Google',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
