import 'package:dio/dio.dart';
import 'package:todo_api/data/entity/user.dart';
import 'package:todo_api/data/repository/user_repository.dart';

class UserRepoImpl extends UserRepository {
  final dio = Dio();
  Map<String, dynamic> userData = {};
  Map<String, dynamic> error = {};

  @override
  Future<bool> createUser(User user) async {
    await dio
        .post('https://todolist-api.edsonmelo.com.br/api/user/new/', data: {
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'password': user.password,
    });
    return true;
  }

  @override
  Future<bool> loginUser(User user) async {
    final response = await dio
        .post('https://todolist-api.edsonmelo.com.br/api/user/login/', data: {
      'username': user.username,
      'password': user.password,
    });
    userData = response.data;
    userData.addAll({'username': user.username});
    return true;
  }

  @override
  Future<bool> deleteUser(User user) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = user.token;
    final response = await dio.delete(
      'https://todolist-api.edsonmelo.com.br/api/user/delete/',
      data: {
        'username': user.username,
        'password': user.password,
      },
    );
    error = response.data;
    return true;
  }

  @override
  Future<bool> updateUser(
      User user, String newUsername, String newPassword) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = user.token;
    final response = await dio.put(
      'https://todolist-api.edsonmelo.com.br/api/user/updateuserpass/',
      data: {
        'username': user.username,
        'password': user.password,
        'new_username': newUsername,
        'new_password': newPassword,
      },
    );
    error = response.data;
    return true;
  }
}
