import 'package:ffe_demo_app/config/tasks/list_of_tasks.dart';
import 'package:ffe_demo_app/models/task/task.dart';

class TaskController {
  static void deleteTask(TaskModel task) {
    listOfTasks.removeWhere((element) => element == task);
  }
  static void createTask(TaskModel task) {
    listOfTasks.add(task);
  }
}
