part of '../task_controller.dart';

Future<TaskModel> _deleteTaskImpl({
  required String id,
  required String token,
}) async {
  Response response = await NetworkEngine.getDio(
    headers: {
      "Authorization": "Bearer $token",
    },
  ).delete(
    TaskController._deleteTaskRoute(id: id),
  );
  if (response.statusCode == 200) {
    TaskModel task = TaskModel.fromJson(response.data["task"]);

    return task;
  }
  throw Exception("Something went wrong. Please try again.");
}
