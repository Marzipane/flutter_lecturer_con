import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/firebase_auth_methods.dart';
import '../../widgets/google_login_button.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login-page';
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign-in')),
      body: Center(
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
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: GoogleLoginButton(
                onTap: () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                },
                text: 'Sign in using google',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
