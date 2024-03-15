part of '../user_controller.dart';

Future<UserModel> _fetchProfileImpl(
    {required String email, required String token}) async {
  /*
   The token is used by the server to identify you. This helps the server, to not
   allow just anyone to access others data.
   */
  Response response = await NetworkEngine.getDio(
    headers: {
      "Authorization": "Bearer $token",
    },
  ).get(
    UserController._getFetchProfilePath(email: email),
  );

  if (response.statusCode == 200) {
    return UserModel.fromJson(response.data);
  }
  throw Exception("Something went wrong. Please try again.");
}
