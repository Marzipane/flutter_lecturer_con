import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lecon/services/who_is_user.dart';
import '../models/users_instance_model.dart';
import '../utils/show_snackbar.dart';
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

  Future signInWithGoogle(BuildContext context) async {
    try {
      // GOOGLE SIGN IN THROUGH WEB
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);

        // var email = userCredential.user!.email;
        // bool isUserStudent = isStudent(email!);
        // THROW OUT IF IT INST LECTURER OF STUDENT;
        // if (!isUserStudent) {
        //   await signOut(context);
        //   await deleteAccount(context);
        // }
        // CHECK NEW GUYS
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            if(isLecturer(userCredential.user!.email) || isStudent(userCredential.user!.email)){
              addUser(googleUser: userCredential);
            }

          }
        }










      // GOOGLE SIGN IN THROUGH IOS AND ANDROID DEVICES
      } else {
        // IOS SIGN IN:      // final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId:DefaultFirebaseOptions.currentPlatform.iosClientId).signIn();

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
          if (userCredential.user != null) {
            if (userCredential.additionalUserInfo!.isNewUser) {
          }
          }
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

  Future addUser({required UserCredential googleUser}) async {
    final docTicket = FirebaseFirestore.instance.collection('users').doc(googleUser.user!.uid);
    final user = UserInstance(
        uid: googleUser.user!.uid,
        email: googleUser.user!.email,
        displayName: googleUser.user!.displayName,
        photoURL: googleUser.user!.photoURL,
        isLecturer: !isStudent(googleUser.user!.email));
    final json = user.toJson();
    await docTicket.set(json);
  }
}



