import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/ui_utils/error_message_dialog.dart';
import 'package:bloc_lesson_example/data/firebase/universal.dart';
import 'package:bloc_lesson_example/ui/app_level/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<UniversalData> signUpUser(
    context, {
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AppLevel(),
          ),
          (route) => false);
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3)),
      );

      return UniversalData(error: e.toString());
    } catch (error) {
      if (context.mounted) {
        showConfirmMessage(message: error.toString(), context: context);
        print(error.toString());
      }
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> loginUser(
    context, {
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3)),
      );
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> logOutUser(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      return UniversalData(data: "User Logged Out");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3)),
      );
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  // Future<UniversalData> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //   await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     return UniversalData(data: userCredential);
  //   } on FirebaseAuthException catch (e) {
  //     return UniversalData(error: e.code);
  //   } catch (error) {
  //     return UniversalData(error: error.toString());
  //   }
  // }
}
