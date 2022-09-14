import 'dart:developer';

import 'package:dio/dio.dart';

class NewApiService {
  final dio = Dio(BaseOptions(responseType: ResponseType.plain));

  Future<Response<dynamic>?> getdata() async {
    try {
      final response = await dio.get(
        "https://randomuser.me/api",
      );
      log(response.toString());
      return response;
    } on DioError catch (e) {
      log(e.message);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
