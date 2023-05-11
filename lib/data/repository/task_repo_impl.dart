import 'package:dio/dio.dart';
import 'package:todo_api/data/repository/task_repository.dart';

import '../entity/task.dart';

class TaskRepoImpl extends TaskRepository {
  final dio = Dio();

  @override
  Future<bool> createTask(Task task, String token) async {
    dio.options.headers['context-Type'] = 'application/json';
    dio.options.headers['authorization'] = token;
    final response = await dio.post(
      'https://todolist-api.edsonmelo.com.br/api/task/new/',
      data: {
        'name': task.name,
      },
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteTask(Task task, String token) async {
    dio.options.headers['context-Type'] = 'application/json';
    dio.options.headers['authorization'] = token;
    final response = await dio.delete(
      'https://todolist-api.edsonmelo.com.br/api/task/delete/',
      data: {
        'id': task.id,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> updateTask(Task task, String token) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = token;
    final response = await dio.put(
      'https://todolist-api.edsonmelo.com.br/api/task/update/',
      data: {
        'id': task.id,
        'name': task.name,
        'realized': task.realized,
      },
    );
    await fetchTasks(token);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<Task>> fetchTasks(String token) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] = token;
    final response = await dio
        .post('https://todolist-api.edsonmelo.com.br/api/task/search/');
    List<Task> tasks = [];

    if (response.statusCode == 200) {
      tasks =
          (response.data as List).map((data) => Task.fromJson(data)).toList();
    }
    return tasks;
  }
}
