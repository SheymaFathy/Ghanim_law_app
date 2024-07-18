import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/profile.dart';

class DioHelper {
  static Dio? dio;
  static String? lang = UserData.lang;
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
      'Authorization': "Bearer ${UserData.uId}",
      'Accept': 'application/json',
      'Accept-Language': lang,
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
      'Accept-Language': lang,
    };

    return dio!.post(url, queryParameters: qurey, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? qurey,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': lang,
    };
    return dio!.delete(url, queryParameters: qurey);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? qurey,
      Map<String, dynamic>? data}) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': lang,
    };

    return dio!.put(url, queryParameters: qurey, data: data);
  }
}
