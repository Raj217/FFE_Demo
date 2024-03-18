import 'package:ffe_demo_app/models/models.dart';
import 'package:ffe_demo_app/states/states.dart';
import 'package:ffe_demo_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  final GlobalKey<AnimatedListState> listKey;
  const CreateTask({super.key, required this.listKey});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
        builder: (context, TasksProvider tasksProvider, _) {
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
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  String token =
                      Provider.of<AuthProvider>(context, listen: false).token!;

                  await tasksProvider.createTask(
                    task: TaskModel(
                      title: _titleController.text,
                      description: _descController.text,
                    ),
                    token: token,
                  );

                  setState(() {
                    if (_titleController.text.isNotEmpty &&
                        _descController.text.isNotEmpty) {
                      showSnackBar(context, "Task added!");
                      Navigator.of(context).pop();

                      widget.listKey.currentState
                          ?.insertItem(tasksProvider.tasks.length - 1);
                    } else {
                      showSnackBar(
                        context,
                        "Please enter the required details!",
                      );
                    }
                  });
                } catch (e) {
                  rethrow;
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text('Submit')),
        ],
      );
    });
  }
}
