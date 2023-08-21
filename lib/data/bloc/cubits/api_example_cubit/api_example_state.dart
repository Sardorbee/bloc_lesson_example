part of 'api_example_cubit.dart';

abstract class ApiExampleState {}

class ApiExampleInitial extends ApiExampleState {}

class ApiExampleLoaded extends ApiExampleState {
  final RandomModel usersData;

  ApiExampleLoaded(this.usersData);
}
