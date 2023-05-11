import 'package:flutter/material.dart';

import '../data/entity/task.dart';

class ListTileTaskWidget extends StatelessWidget {
  const ListTileTaskWidget({
    Key? key,
    required this.task,
    required this.deleteTask,
    required this.onTap,
  }) : super(key: key);

  final Task task;
  final Function() deleteTask;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                task.name,
                style: TextStyle(
                  decoration:
                      task.realized == 1 ? TextDecoration.lineThrough : null,
                  fontSize: 20,
                  color: task.realized == 1 ? Colors.grey : null,
                ),
              )),
              IconButton(
                  onPressed: deleteTask, icon: const Icon(Icons.close_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
