import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lecon/services/who_is_user.dart';
import '../utils/showSnackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);

        var email = userCredential.user!.email;
        bool isUserStudent = isStudent(email!);
        bool isUserLecturer = isLecturer(email);
        // THROW OUT IF IT ISNT LECTURER OF STUDENT;
        if (!isUserStudent && !isUserLecturer) {
          await signOut(context);
          await deleteAccount(context);
        }
        // CHECK NEW GUYS
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            if (isUserStudent) {
              FirebaseFirestore.instance.collection('users').add({
                'email': userCredential.user!.email,
                'name': userCredential.user!.displayName,
                'isLecturer': false,
              });
            } else if (isUserLecturer) {
              FirebaseFirestore.instance.collection('users').add({
                'email': userCredential.user!.email,
                'name': userCredential.user!.displayName,
                'isLecturer': true,
              });
            } else {
              // TODO: THROW USER OUT AND DON'T ALLOW

              // await signOut(context);
            }
          }
        }
      } else {
        // IOS GOOGLE SIGN IN
        // final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId:DefaultFirebaseOptions.currentPlatform.iosClientId).signIn();
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          // TODO: REALIZE FIREBASE STORAGE
          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:
          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {
          // }
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
