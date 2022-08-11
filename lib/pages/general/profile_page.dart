import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../main.dart';
import '../../widgets/custom_button.dart';
import '../student/read_student_data.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-page';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setPageTitle('Profile', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();

    return Scaffold(
      appBar: AppBars().builtStudentAppBar(user: user, context: context, title: 'Profile page', auth: auth),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 40),
            InkWell(
              onHover: (){}(),
              onTap: (){
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user can tap anywhere to close a dialog
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Change Avatar'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Write an URL of your image'),
                          SizedBox(height: 20,),
                          SizedBox(
                            height: 40,
                            width: 300,
                            child: TextField(

                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel',style: TextStyle(color: AppColors.ErrorRed),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Submit',style: TextStyle(color: AppColors.Green),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: SizedBox(height: 300, width: 300,
              child: Image.network(user.photoURL ??
                  'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png'),),
            ),
          const SizedBox(
            height: 8,
          ),
          Text(user.displayName ?? ''),
          SizedBox(height: 2,),
          Text(user.email ?? ''),
          SizedBox(height: 2,),
          buildStudentStreamBuilder(user.uid),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 300,
            child: CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context).then(
                    (value) => Navigator.popAndPushNamed(
                        context, AuthWrapper.routeName));
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
