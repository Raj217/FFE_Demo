import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ffe_demo_app/widgets/widgets.dart';

class ErrorHandler {
  const ErrorHandler._();

  static void _errorBuilder() {
    Widget error = const Text("Unknown build error...");
    ErrorWidget.builder = (errorDetails) {
      // debugPrint(errorDetails.toString());
      return Material(
        child: Scaffold(
          body: Center(
            child: error,
          ),
        ),
      );
    };
  }

  static void _flutterErrorBuilder(BuildContext context) {
    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrint(details.exception.toString());

      /// TODO: Improvise required
      /// The message should not always render what it gets as sometimes it might be too large
      /// Added a maximum size for error message after which it will be truncated
      debugPrintStack(stackTrace: details.stack);
      // String errorMessage = details.exception.toString();
      // int maxSize = 100;
      // if (errorMessage.length > maxSize) {
      //   errorMessage =
      //       "${details.toStringShort()}:\nPlease contact us if error persists";
      // }
      // showErrorSnackBar(context, errorMessage);
    };
  }

  static void _platformErrorBuilder(BuildContext context) {
    // Widget error = const Text("Unknown platform error...");
    PlatformDispatcher.instance.onError = (obj, stack) {
      debugPrint(obj.toString());
      debugPrintStack(stackTrace: stack);

      late String errorMessage;
      if (obj is DioException) {
        if (obj.response?.data != null) {
          dynamic body = obj.response?.data!;
          errorMessage = body["message"] ??
              "Some error occurred. Please retry or restart the app.";
        } else {
          errorMessage =
              "Some error occurred. Please retry or restart the app.";
        }
      } else if (obj is Exception) {
        errorMessage = obj.toString().substring("Exception: ".length);
      } else {
        errorMessage = "Some error occurred. Please retry or restart the app.";
      }
      showSnackBar(context, errorMessage);
      // error;
      return true;
    };
  }

  static Widget handle(BuildContext context, Widget? child) {
    // Currently commented due to infinite build error
    // TODO: If required fix it
    // _errorBuilder();
    // _flutterErrorBuilder(context);
    _platformErrorBuilder(context);

    if (child != null) return child;
    throw ('child is null');
  }
}
