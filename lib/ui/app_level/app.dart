
import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/listen_user_cubit.dart';
import 'package:bloc_lesson_example/ui/auth/sign_in_screen/sign_in.dart';
import 'package:bloc_lesson_example/ui/tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLevel extends StatefulWidget {
  const AppLevel({
    super.key,
  });

  @override
  State<AppLevel> createState() => _AppLevelState();
}

class _AppLevelState extends State<AppLevel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, User?>(
      builder: (context, user) {
        if (user != null) {
          return const MyTabBar();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
