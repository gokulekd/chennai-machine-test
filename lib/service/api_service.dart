import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio(BaseOptions(responseType: ResponseType.plain));

  Future<Response<dynamic>?> getdata() async {
    try {
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );

      return response;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
