import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/view/edit_user_screen.dart';
import 'package:todo_api/view/login_screen.dart';
import 'package:todo_api/widgets/default_button_widget.dart';
import 'package:todo_api/widgets/input_form_widget.dart';
import 'package:todo_api/widgets/list_tile_task_widget.dart';

import '../constants/constants.dart';
import '../data/controller/task_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TaskController>();
    controller.loadTasks(widget.user['token']);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Início')),
        actions: [
          IconButton(
            onPressed: () {
              controller.listTasks.clear();
              widget.user.clear();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(children: [
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Card(
                          child: IconButton(
                              iconSize: 20.0,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EditUserScreen(user: widget.user))),
                              icon: const Icon(
                                Icons.edit,
                              ))),
                    ),
                    Column(
                      children: [
                        const Text(
                          'Minha conta',
                          style: titleStyle,
                        ),
                        Row(
                          children: [
                            const Text(
                              'ID: ',
                              style: italicStyle,
                            ),
                            Text(
                              widget.user['id'].toString(),
                              style: userStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Nome: ',
                              style: italicStyle,
                            ),
                            Text(
                              widget.user['name'],
                              style: userStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Username: ',
                              style: italicStyle,
                            ),
                            Text(
                              widget.user['username'],
                              style: userStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Email: ',
                              style: italicStyle,
                            ),
                            Text(
                              widget.user['email'],
                              style: userStyle,
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              Expanded(
                child: Card(
                  child: Consumer<TaskController>(
                      builder: (context, controller, _) {
                    final tasks = controller.listTasks;

                    if (tasks.isEmpty) {
                      return const Center(
                          child: Text(
                        'Nenhuma tarefa...',
                        style: italicStyle,
                      ));
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTileTaskWidget(
                              task: tasks[index],
                              deleteTask: () => controller.deleteTask(
                                  index, widget.user['token']),
                              onTap: () => controller.onTapTask(
                                  index, widget.user['token'])),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return Form(
                key: _formKey,
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InputFormWidget(
                          obscureText: false,
                          controller: _task,
                          formEmpty: 'Informe sua tarefa',
                          hintText: 'Tarefa',
                        ),
                        DefaultButtonWidget(
                          onPressed: () async {
                            await controller.createTask(
                                _task.text, widget.user['token']);
                            await controller.loadTasks(widget.user['token']);
                            _task.text = '';
                            if (context.mounted) Navigator.pop(context);
                          },
                          title: 'Adicionar',
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        label: const Icon(Icons.add),
      ),
    );
  }
}
