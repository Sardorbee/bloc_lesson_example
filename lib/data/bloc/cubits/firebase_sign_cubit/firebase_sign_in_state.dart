part of 'firebase_sign_in_cubit.dart';

@immutable
abstract class FirebaseSignInState {}

final class FirebaseUnAuthorized extends FirebaseSignInState {}
final class FirebaseAuthorized extends FirebaseSignInState {}
final class FirebaseSignInLoading extends FirebaseSignInState {}
final class FirebaseSignInError extends FirebaseSignInState {}
