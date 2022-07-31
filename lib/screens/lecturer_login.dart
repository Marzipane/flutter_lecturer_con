import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/custom_button.dart';

class LecturerLogin extends StatelessWidget {
  static const routeName = '/lecturer-login';
  const LecturerLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lecturer Sign-in')),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Lecturer Login',
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: CustomButton(
                onTap: () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                  
                },
                text: 'Lecturer sign-in',
                icon: FontAwesomeIcons.google,
                iconColor: Color.fromARGB(244, 180, 0, 1)),
          )
        ]),
      ),
    );
  }
}
