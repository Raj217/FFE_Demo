part of '../user_controller.dart';

Future<UserControllerResponse> _loginImpl({
  required String email,
  required String password,
}) async {
  // Preparing the body to send.
  Map body = {"email": email, "password": password};
  String bodyEncoded = jsonEncode(body);

  Response response = await NetworkEngine.getDio().post(
    UserController._getLoginPath(),
    data: bodyEncoded,
  );
  if (response.statusCode == 200) {
    UserModel user = UserModel.fromJson(response.data["user"]);
    String token = response.data["token"];

    return UserControllerResponse(model: user, token: token);
  }
  throw Exception("Something went wrong. Please try again.");
}
