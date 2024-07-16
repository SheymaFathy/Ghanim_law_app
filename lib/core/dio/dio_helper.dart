import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://ghanimlawfirm.laraeast.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? qurey,
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
    };
    return await dio?.get(
      url,
      queryParameters: qurey,
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? qurey,
      Map<String, dynamic>? data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
    };

    return dio!.post(url, queryParameters: qurey, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? qurey,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
    };
    return dio!.delete(url, queryParameters: qurey);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? qurey,
      Map<String, dynamic>? data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
    };

    return dio!.put(url, queryParameters: qurey, data: data);
  }
}
