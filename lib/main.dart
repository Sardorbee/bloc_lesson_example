import 'package:bloc_lesson_example/data/bloc/cubits/api_example_cubit/api_example_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/button_Color_cubit/button_color_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/firebase_sign_in_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/listen_user_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/navdar_cubit/navbar_cubit_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/number_multiplier_cubit/nuber_multiplayer_cubit.dart';
import 'package:bloc_lesson_example/ui/app_level/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NavbarCubit(),
      ),
      BlocProvider(
        create: (context) => ButtonColorCubit(),
      ),
      BlocProvider(
        create: (context) => ApiExampleCubit(),
      ),
      BlocProvider(
        create: (context) => NuberMultiplayerCubit(),
      ),
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(
        create: (context) => FirebaseSignInCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppLevel(),
    );
  }
}
