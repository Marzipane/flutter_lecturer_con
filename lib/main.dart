import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/screens/home_page.dart';
import 'package:flutter_lecon/screens/student_profile_page.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'route_generator.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/lecturer_profile_page.dart';
import 'services/who_is_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromRGBO(0, 0, 128, 1.0)
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          //       textStyle:
          //           const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          // ),
          ),
      home: const AuthWrapper(),
    ),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    var email = firebaseUser?.email;

    if (firebaseUser != null) {
      // CHECK IF IT'S A LECTURER
      if (isLecturer(email!)) {
        return const LecturerProfilePage();
      }
      if (isStudent(email)) {
        return const StudentProfilePage();
      }

    }
    return const HomePage();
  }
}
