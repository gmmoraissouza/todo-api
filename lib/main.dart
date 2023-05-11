import 'package:flutter/material.dart';
import 'package:todo_api/constants/constants.dart';
import 'package:todo_api/data/controller/task_controller.dart';
import 'package:todo_api/data/repository/task_repo_impl.dart';
import 'package:todo_api/data/repository/task_repository.dart';
import 'package:todo_api/view/login_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        Provider<TaskRepository>(create: (_) => TaskRepoImpl()),
        ChangeNotifierProvider<TaskController>(
            create: (context) =>
                TaskController(context.read<TaskRepository>())),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo API',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: const LoginScreen(),
    );
  }
}
