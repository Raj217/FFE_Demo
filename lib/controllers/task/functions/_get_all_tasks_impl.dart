part of '../task_controller.dart';

Future<List<TaskModel>> _getAllTasksImpl({
  required String token,
}) async {
  Response response = await NetworkEngine.getDio(
    headers: {
      "Authorization": "Bearer $token",
    },
  ).get(
    TaskController._getAllTasksRoute(),
  );
  if (response.statusCode == 200) {
    List<TaskModel> tasks = [];
    for (dynamic taskJson in response.data["tasks"]) {
      tasks.add(TaskModel.fromJson(taskJson));
    }

    return tasks;
  }
  throw Exception("Something went wrong. Please try again.");
}
