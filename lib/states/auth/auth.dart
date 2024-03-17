import 'package:ffe_demo_app/config/config.dart';
import 'package:ffe_demo_app/controllers/controllers.dart';
import 'package:ffe_demo_app/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  String? _token;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  SharedPreferences? prefs;

  Future<bool> checkIfUserIsLoggedIn() async {
    prefs ??= await SharedPreferences.getInstance();

    String? token = prefs!.getString(LocalStorageKeys.token.name);
    if (token != null) {
      _token = token;
      notifyListeners();

      return true;
    }
    return false;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    UserControllerResponse res = await UserController.login(
      email: email,
      password: password,
    );
    _token = res.token;
    _currentUser = res.user;

    prefs ??= await SharedPreferences.getInstance();
    prefs!.setString(LocalStorageKeys.token.name, _token!);

    notifyListeners();
  }

  Future<void> signup({
    required UserModel user,
    required String password,
  }) async {
    UserControllerResponse res = await UserController.signUp(
      user: user,
      password: password,
    );
    _token = res.token;
    _currentUser = res.user;

    prefs ??= await SharedPreferences.getInstance();
    prefs!.setString(LocalStorageKeys.token.name, _token!);

    notifyListeners();
  }
}
