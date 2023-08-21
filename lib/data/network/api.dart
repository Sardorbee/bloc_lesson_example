import 'package:bloc_lesson_example/data/network/random_user_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<RandomModel> fetchData() async {
    try {
      final response = await _dio.get('https://randomuser.me/api/');

      if (response.statusCode == 200) {
        RandomModel firstModel = RandomModel.fromJson(response.data);
        return firstModel;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception(error.toString());
    }
  }
}
