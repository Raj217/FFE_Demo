import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ffe_demo_app/models/task/task.dart';
import 'package:ffe_demo_app/utils/network_engine/network_engine.dart';

part 'functions/_get_all_tasks_impl.dart';
part 'functions/_delete_task_impl.dart';
part 'functions/_create_task_impl.dart';

class TaskController {
  static Future<List<TaskModel>> getAllTasks({required String token}) async {
    return await _getAllTasksImpl(
      token: token,
    );
  }

  static Future<TaskModel> deleteTask({
    required String token,
    required String id,
  }) async {
    return await _deleteTaskImpl(
      token: token,
      id: id,
    );
  }

  static Future<TaskModel> createTask({
    required String token,
    required TaskModel task,
  }) async {
    return await _createTaskImpl(
      task: task,
      token: token,
    );
  }

  // =================================== Paths ========================================= //
  static const String _taskBaseRoute = "/task";
  static String _createTaskRoute() {
    return _taskBaseRoute;
  }

  static String _getAllTasksRoute() {
    return _taskBaseRoute;
  }

  static String _deleteTaskRoute({required String id}) {
    return "$_taskBaseRoute/$id";
  }
}
