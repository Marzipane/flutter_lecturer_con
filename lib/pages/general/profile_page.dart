import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:flutter_lecon/widgets/appbars.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../widgets/profile_body.dart';


class LecturerProfilePage extends StatelessWidget {
  static const routeName = '/lecturer-profile-page';
  const LecturerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setPageTitle('Profile', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();

    return Scaffold(
      appBar: AppBars().builtLecturerAppBar(user: user, context: context, title: 'Profile page', auth: auth),
      body: ProfileBody(user: user),
      backgroundColor: AppColors.LightSilver,
    );
  }
}


class StudentProfilePage extends StatelessWidget {
  static const routeName = '/student-profile-page';
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setPageTitle('Profile', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();

    return Scaffold(
      appBar: AppBars().builtStudentAppBar(user: user, context: context, title: 'Profile page', auth: auth),
      body: ProfileBody(user: user),
      backgroundColor: AppColors.LightSilver,
    );
  }
}

