import 'package:bloc_lesson_example/data/firebase/auth.dart';
import 'package:bloc_lesson_example/data/firebase/universal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'firebase_sign_in_state.dart';

class FirebaseSignInCubit extends Cubit<FirebaseSignInState> {
  FirebaseSignInCubit() : super(FirebaseUnAuthorized());

  Future<void> signUpUser(
    BuildContext context, {
    String email = '',
    String password = '',
  }) async {
    emit(FirebaseSignInLoading());

    UniversalData data = await AuthService()
        .signUpUser(context, email: email, password: password);
    if (data.error.isEmpty) {
      UserCredential user = data.data;

      if (user.user != null) {
        emit(FirebaseAuthorized());
      } else if (user.user == null) {
        emit(FirebaseUnAuthorized());
      } else {
        emit(FirebaseUnAuthorized());
      }
    } else {
      emit(FirebaseSignInError());
    }
  }

  Future<void> signInUser(BuildContext context,
      {String email = '', String password = ''}) async {
    emit(FirebaseSignInLoading());
    UniversalData data = await AuthService()
        .loginUser(context, email: email, password: password);
    if (data.error.isEmpty) {
      {
        UserCredential user = data.data;

        if (user.user != null) {
          emit(FirebaseAuthorized());
        } else if (user.user == null) {
          emit(FirebaseUnAuthorized());
        } else {
          emit(FirebaseUnAuthorized());
        }
      }
    }
  }

  Future<void> signOutUser(
    BuildContext context,
  ) async {
    emit(FirebaseSignInLoading());
    await AuthService().logOutUser(context);
    emit(FirebaseUnAuthorized());
  }
}
