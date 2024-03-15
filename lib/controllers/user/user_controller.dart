import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ffe_demo_app/models/models.dart';
import 'package:ffe_demo_app/utils/network_engine/network_engine.dart';

part 'functions/_login_impl.dart';
part 'functions/_sign_up_impl.dart';
part 'functions/_fetch_profile_impl.dart';

/// The UserController is responsible for all the user related controls with the API.
class UserController {
  /*
  The line below makes sure that no instance of the class is created.

  The class is only responsible for controllers here are the operations.
  A class is made for the sole purpose of grouping the operations.
  Thus there is no need to create an instance of this class and
  all member methods can be static.
  */
  const UserController._();

  /// Validates the user if exists in the database.
  /// If the user exists it returns a [UserControllerResponse] object
  /// which contains user data and token.
  ///
  /// The token can be used to access other other API paths.
  static Future<UserControllerResponse> login({
    required String email,
    required String password,
  }) async {
    return await _loginImpl(
      email: email,
      password: password,
    );
  }

  /// Validates the user and then if validated creates a new user.
  /// Upon creating a new user it returns a [UserControllerResponse] object
  /// which contains user data and token.
  ///
  /// The token can be used to access other other API paths.
  static Future<UserControllerResponse> signUp({
    required UserModel user,
    required String password,
  }) async {
    return await _signUpImpl(
      user: user,
      password: password,
    );
  }

  /// Upon passing an [email], if the API allows the user, it sends back the profile
  /// of the user associated with that email.
  static Future<UserModel> fetchProfile({
    required String email,
    required String token,
  }) async {
    return await _fetchProfileImpl(
      email: email,
      token: token,
    );
  }

  // =================================== Paths ========================================= //
  static const String _userBaseRoute = "/user";
  static String _getLoginPath() {
    return "$_userBaseRoute/login";
  }

  static String _getSignUpPath() {
    return "$_userBaseRoute/sign-up";
  }

  static String _getFetchProfilePath({required String email}) {
    return "$_userBaseRoute/$email";
  }
}

/// This class is necessary for storing extra information with the user model
/// like [token]
class UserControllerResponse {
  final UserModel model;
  final String token;
  const UserControllerResponse({required this.model, required this.token});
}
