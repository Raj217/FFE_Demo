import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@Freezed(fromJson: true, toJson: true)
class TaskModel with _$TaskModel {
  /// This is a basic Task class which stores tasks data.
  /// For the simplicity of the app we will be storing only
  /// * [id] of the task
  /// * [title] of the task
  /// * [description] of the task

  const TaskModel._();

  const factory TaskModel({
    String? id,
    required String title,
    required String description,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
