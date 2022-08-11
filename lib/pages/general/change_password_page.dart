import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/set_page_title.dart';
import '../../services/firebase_auth_methods.dart';
import '../../widgets/appbars.dart';
import '../../widgets/change_password_widget.dart';


class ChangeStudentPasswordPage extends StatelessWidget {

  static const routeName = '/change-student-password-page';

  ChangeStudentPasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setPageTitle('Student | Password', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
      appBar: AppBars().builtStudentAppBar(
          user: user, context: context, title: 'Password', auth: auth),
      body: ChangePasswordWidget()
    );
  }


}

class ChangeLecturerPasswordPage extends StatelessWidget {

  static const routeName = '/change-lecturer-password-page';

  ChangeLecturerPasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setPageTitle('Lecturer | Password', context);
    final user = context.read<FirebaseAuthMethods>().user;
    final auth = context.read<FirebaseAuthMethods>();
    return Scaffold(
        appBar: AppBars().builtLecturerAppBar(
            user: user, context: context, title: 'Password', auth: auth),
        body: ChangePasswordWidget()
    );
  }


}

