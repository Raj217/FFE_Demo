import 'package:ffe_demo_app/config/tasks/list_of_tasks.dart';
import 'package:ffe_demo_app/controllers/task/task_controller.dart';
import 'package:ffe_demo_app/models/models.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  final GlobalKey<AnimatedListState> listKey;
  const CreateTask({super.key, required this.listKey});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? title, desc;
    return AlertDialog(
      title: const Text('Add a Task'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration:
                  const InputDecoration(hintText: 'Enter the Description'),
            )
          ]),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                if (_titleController.text.isNotEmpty &&
                    _descController.text.isNotEmpty) {
                  TaskController.createTask(TaskModel(
                      title: _titleController.text,
                      description: _descController.text));
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Task added!")));
                  Navigator.of(context).pop();
                  widget.listKey.currentState
                      ?.insertItem(listOfTasks.length - 1);
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please enter the required details!")));
                }
              });
            },
            child: const Text('Submit')),
      ],
    );
  }
}
