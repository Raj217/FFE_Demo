part of '../user_controller.dart';

Future<UserControllerResponse> _signUpImpl({
  required UserModel user,
  required String password,
}) async {
  // Preparing the body to send.
  Map body = user.toJson();
  /*
   We are not including password in the model as it is not safe to store the password.
   The validation of password should be done at the server directly.

   */
  body["password"] = password;

  String bodyEncoded = jsonEncode(body);

  Response response = await NetworkEngine.getDio().post(
    UserController._getSignUpPath(),
    data: bodyEncoded,
  );
  if (response.statusCode == 201) {
    UserModel user = UserModel.fromJson(response.data["user"]);
    String token = response.data["token"];

    return UserControllerResponse(user: user, token: token);
  }
  throw Exception("Something went wrong. Please try again.");
}
