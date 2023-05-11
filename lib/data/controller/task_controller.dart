import 'package:flutter/material.dart';
import 'package:todo_api/data/repository/task_repository.dart';

import '../entity/task.dart';

class TaskController extends ChangeNotifier {
  final TaskRepository taskRepository;
  List<Task> listTasks = [];

  TaskController(this.taskRepository);

  Future<List<Task>> loadTasks(String token) async {
    listTasks = await taskRepository.fetchTasks(token);
    notifyListeners();
    return listTasks;
  }

  Future<void> onTapTask(int index, String token) async {
    switch (listTasks[index].realized) {
      case 0:
        final task = listTasks[index].copyWith(realized: 1);
        listTasks.replaceRange(index, index + 1, [task]);
        await taskRepository.updateTask(task, token);
        break;
      case 1:
        final task = listTasks[index].copyWith(realized: 0);
        listTasks.replaceRange(index, index + 1, [task]);
        await taskRepository.updateTask(task, token);
        break;
    }

    notifyListeners();
  }

  Future createTask(String title, String token) async {
    final task = Task(name: title);
    await taskRepository.createTask(task, token);

    notifyListeners();
  }

  Future<void> deleteTask(int index, String token) async {
    final task = listTasks[index];

    final sucess = await taskRepository.deleteTask(task, token);

    if (sucess) {
      listTasks.remove(task);
    }
    notifyListeners();
  }
}
