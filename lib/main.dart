import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/pages/student/tickets_list_page.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'pages/general/login_page.dart';
import 'pages/student/student_home_page.dart';
import 'route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/lecturer/lecturer_home_page.dart';
import 'services/who_is_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(MultiProvider(
    providers: [
      Provider<FirebaseAuthMethods>(
        create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
      ),
      StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null),
    ],
    child: MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: AppTheme(),
      home: const AuthWrapper(),
    ),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? email = firebaseUser?.email;

    if (firebaseUser != null) {
      if (isStudent(email!)) {
        return LecturerHomePage();
      } else {
        return TicketsListPage();
      }
    }
    return const LoginPage();
  }
}
