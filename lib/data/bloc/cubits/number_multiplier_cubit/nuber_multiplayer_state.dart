// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class NumberState {}

class ResultState extends NumberState {
  final int result;

  ResultState({
    required this.result,
  });
}

class InitialState extends NumberState {}
