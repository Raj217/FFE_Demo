import 'package:dio/dio.dart';
import 'package:ffe_demo_app/config/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// This class is responsible for providing a medium to connect between the app
/// and the API.
class NetworkEngine {
  static Dio?
      dio; // Ensuring the dio is created only once and is reused again and again throughout the app.

  NetworkEngine._();

  static Dio getDio({
    Map<String, dynamic>? headers,
  }) {
    if (dio != null) return dio!;

    // The line below retrieves the value of BASE_URL from .env
    String baseURL = dotenv.env[EnvValues.BASE_URL.name]!;
    // Sets up some basic values for dio.
    dio = Dio(
      BaseOptions(
        headers: {'content-type': "application/json", ...(headers ?? {})},
        baseUrl: baseURL,
      ),
    );

    /*
    If in debug mode it adds some interceptors to better inspect the messages that
    are being sent over the network to the server and what errors are being returned upon what values.

     */
    if (kDebugMode) {
      dio!.interceptors.add(
        InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
          debugPrint('''
        ******************************************************************************************************

        ${error.message} || ${error.response}

        ******************************************************************************************************
        ''');
          return errorInterceptorHandler.next(error);
        }, onRequest: (request, requestInterceptorHandler) {
          debugPrint('''
        ******************************************************************************************************

        ${request.method} || ${request.baseUrl}${request.path} ||| ${request.data}

        ******************************************************************************************************
        ''');
          return requestInterceptorHandler.next(request);
        }, onResponse: (response, responseInterceptorHandler) {
          debugPrint('''
          -******************************************************************************************************
          ${response.statusMessage} || ${response.statusCode} |||| ${response.data}
          --******************************************************************************************************
          ''');

          return responseInterceptorHandler.next(response);
        }),
      );
    }
    return dio!;
  }
}
