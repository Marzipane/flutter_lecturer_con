import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/pages/lecturer/firbase_read.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../common/app_theme.dart';
import '../main.dart';
import '../pages/student/read_student_data.dart';
import '../services/firebase_auth_methods.dart';
import 'custom_button.dart';

// class ProfileBody extends StatelessWidget {
//   const ProfileBody({
//     Key? key,
//     required this.user,
//   }) : super(key: key);
//
//   final User user;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(children: [
//         const SizedBox(height: 40),
//         InkWell(
//           onHover: (){}(),
//           onTap: (){
//             showDialog<void>(
//               context: context,
//               barrierDismissible: true, // user can tap anywhere to close a dialog
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Change Avatar'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('Enter a URL of an image'),
//                       SizedBox(height: 20,),
//                       SizedBox(
//                         height: 40,
//                         width: 300,
//                         child: TextField(
//
//                         ),
//                       )
//                     ],
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('Cancel',style: TextStyle(color: AppColors.ErrorRed),),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     TextButton(
//                       child: const Text('Submit',style: TextStyle(color: AppColors.Green),),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//           child: SizedBox(height: 300, width: 300,
//             child: Image.network(user.photoURL ??
//                 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Gau-logo.png'),),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         Text(user.displayName ?? ''),
//         SizedBox(height: 2,),
//         Text(user.email ?? ''),
//         SizedBox(height: 2,),
//         buildStudentStreamBuilder(user.uid),
//         const SizedBox(
//           height: 16,
//         ),
//         SizedBox(
//           width: 300,
//           child: CustomButton(
//             onTap: () {
//               context.read<FirebaseAuthMethods>().signOut(context).then(
//                       (value) => Navigator.pushNamedAndRemoveUntil(
//                       context, '/', (route) => false));
//             },
//             text: 'Sign Out',
//             icon: FontAwesomeIcons.rightFromBracket,
//             iconColor: AppColors.LightRed,
//
//           ),
//         ),
//         const SizedBox(height: 10),
//       ]),
//     );
//   }
// }

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

    return buildProfileStreamBuilder(user.uid, formKey, _urlController, firebaseUser);
  }
}
