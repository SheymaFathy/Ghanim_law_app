import 'dart:convert';

import 'package:dio/dio.dart';

abstract class Faliure {
  final String erorrMessage;

  Faliure(this.erorrMessage);
}

class ServerFaliure extends Faliure {
  ServerFaliure(super.erorrMessage);
  factory ServerFaliure.fromDioErorr(DioException dioErorr) {
    switch (dioErorr.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFaliure("Connection Timeout With Api Server");

      case DioExceptionType.sendTimeout:
        return ServerFaliure("Send Timeout With Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerFaliure("Receive Timeout With Api Server");
      case DioExceptionType.badResponse:
        return ServerFaliure.fromResponse(
            dioErorr.response!.statusCode!, dioErorr.response);
      case DioExceptionType.cancel:
        return ServerFaliure("Request to Api Server Was Canceld");

      case DioExceptionType.unknown:
        if (dioErorr.message != null) {
          if (dioErorr.message!.contains('SocketException')) {
            return ServerFaliure("No InterNet Connection");
          }
        } else {
          return ServerFaliure("No InterNet Connection");
        }
        return ServerFaliure("Unexpected Erorr, Plase ty again!");
      default:
        return ServerFaliure("Opps There Was am Erorr");
    }
  }
  factory ServerFaliure.fromResponse(int stutusCode, dynamic response) {
    if (stutusCode == 400 || stutusCode == 401 || stutusCode == 403) {
      return ServerFaliure('Unauthenticated');
    } else if (stutusCode == 404) {
      return ServerFaliure("Your Request Not Found, Please try later!");
    } else if (stutusCode == 500) {
      return ServerFaliure("Internal Server Erorr, Please try later!");
    } else if (stutusCode == 422) {
      final Map<String, dynamic> decode = jsonDecode(response.toString());
      print(decode['message']);
      return ServerFaliure(decode['message']);
    } else {
      return ServerFaliure("Opps There Was am Erorr");
    }
  }
}
