import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(fromJson: true, toJson: true)
class UserModel with _$UserModel {
  /// This is a basic User class which stores user data.
  /// For the simplicity of the app we will be storing only
  /// * [id] of the user
  /// * [name] of the user
  /// * [mail] of the user
  ///
  /// The password is not stored and is directly passed to the controller while
  /// the user sign up or login
  const UserModel._();

  const factory UserModel({
    String? id,
    required String username,
    required String mail,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
