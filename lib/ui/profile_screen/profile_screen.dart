import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/firebase_sign_in_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/listen_user_cubit.dart';
import 'package:bloc_lesson_example/ui/utils/loading_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<FirebaseSignInCubit>().signOutUser(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<AuthCubit, User?>(
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      state!.email!,
                      style: const TextStyle(fontSize: 30),
                    ),
                  )
                ],
              );
            },
          ),
          BlocBuilder<FirebaseSignInCubit, FirebaseSignInState>(
            builder: (context, state) {
              return Visibility(
                  visible: state is FirebaseSignInLoading,
                  child: const LoadingPage());
            },
          )
        ],
      ),
    );
  }
}
