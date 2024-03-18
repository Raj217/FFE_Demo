import 'package:ffe_demo_app/controllers/task/task_controller.dart';
import 'package:ffe_demo_app/models/models.dart';
import 'package:flutter/foundation.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> fetchAllTask({
    required String token,
  }) async {
    _tasks = await TaskController.getAllTasks(token: token);
  }

  Future<void> createTask({
    required TaskModel task,
    required String token,
  }) async {
    TaskModel newTask = await TaskController.createTask(
      token: token,
      task: task,
    );

    /*
    This is important and we can't directly add a new task to the list.
    The reason being provider wont understand that the task list was updated and
    so the changes might not be reflected everywhere.
     */
    _tasks = [..._tasks, newTask];
    notifyListeners();
  }

  Future<void> deleteTask({
    required String id,
    required String token,
  }) async {
    TaskModel deletedTask = await TaskController.deleteTask(
      token: token,
      id: id,
    );

    /*
    Due to the same reason as before we need to do this in this way
     */
    List<TaskModel> updatedTasks = _tasks;
    updatedTasks.remove(deletedTask);
    _tasks = updatedTasks;

    notifyListeners();
  }
}
