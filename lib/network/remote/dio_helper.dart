import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    late Response response;

    try {
      response = await dio.get(url, queryParameters: query);
    } on DioError catch (error) {
      debugPrint("Dio Error $error");
    }

    return response;
  }
}
