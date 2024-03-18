part of '../task_controller.dart';

Future<TaskModel> _createTaskImpl({
  required TaskModel task,
  required String token,
}) async {
  // Preparing the body to send.
  Map body = task.toJson();

  String bodyEncoded = jsonEncode(body);

  Response response = await NetworkEngine.getDio(
    headers: {
      "Authorization": "Bearer $token",
    },
  ).post(
    TaskController._createTaskRoute(),
    data: bodyEncoded,
  );
  if (response.statusCode == 201) {
    TaskModel task = TaskModel.fromJson(response.data["task"]);

    return task;
  }
  throw Exception("Something went wrong. Please try again.");
}
