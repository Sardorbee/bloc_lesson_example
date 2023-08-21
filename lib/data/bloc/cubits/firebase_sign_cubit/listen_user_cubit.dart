import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<User?> {
  final auth = FirebaseAuth.instance;
  late StreamSubscription<User?> _authStateSubscription;

  AuthCubit() : super(null) {
    _authStateSubscription = auth.authStateChanges().listen((user) {
      emit(user);
    });
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
