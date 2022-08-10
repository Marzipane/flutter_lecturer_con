import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecon/common/app_theme.dart';
import 'package:flutter_lecon/pages/general/add_user_data_page.dart';
import 'package:flutter_lecon/pages/student/student_home_page.dart';
import 'package:flutter_lecon/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'pages/general/login_page.dart';
import 'route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/lecturer/lecturer_home_page.dart';

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
  static const routeName = '/auth-wrapper';

  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final firebaseUser = context.watch<User?>();
    String? email = firebaseUser?.email;

    if (firebaseUser != null) {
      return FutureBuilder(
          future: users.doc(firebaseUser.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (firebaseUser.uid == data['uid']) {
                // IF USER IS LECTURER
                if (data['isLecturer']) {
                  if (data['password'] == null) {
                    return AddUserDataPage(
                        docId: firebaseUser.uid,
                        isLecturer: data['isLecturer']);
                  }
                  return LecturerHomePage(data: data);
                }
                // OTHERWISE, IT IS A STUDENT
                else {
                  if (data['studentNumber'] == null ||
                      data['password'] == null) {
                    return AddUserDataPage(
                        docId: firebaseUser.uid,
                        isLecturer: data['isLecturer']);
                  }
                  return StudentHomePage(data: data);
                }
              }
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          });
    }
    return const LoginPage();
  }
}
