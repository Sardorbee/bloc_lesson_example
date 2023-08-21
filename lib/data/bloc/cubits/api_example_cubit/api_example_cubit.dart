import 'package:bloc/bloc.dart';
import 'package:bloc_lesson_example/data/network/api.dart';
import 'package:bloc_lesson_example/data/network/random_user_model.dart';

part 'api_example_state.dart';

class ApiExampleCubit extends Cubit<ApiExampleState> {
  ApiExampleCubit() : super(ApiExampleInitial()) {
    getRandomUser();
  }

  Future<void> getRandomUser() async {
    RandomModel randomModel = await ApiService().fetchData();

    emit(ApiExampleLoaded(randomModel));
  }
}
