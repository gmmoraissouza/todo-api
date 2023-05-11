import 'package:todo_api/data/entity/task.dart';

abstract class TaskRepository{
  Future<List<Task>> fetchTasks(String token);
  Future<bool> createTask(Task task, String token);
  Future<bool> updateTask(Task task, String token);
  Future<bool> deleteTask(Task task, String token);
}