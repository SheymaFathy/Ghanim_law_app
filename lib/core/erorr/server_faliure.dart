import 'dart:convert';

import 'package:dio/dio.dart';

abstract class Faliure {
  final String erorrMessage;
  final int? statusCode;
  Faliure({required this.erorrMessage, this.statusCode});
}

class ServerFaliure extends Faliure {
  ServerFaliure({required super.erorrMessage, super.statusCode});
  factory ServerFaliure.fromDioErorr(DioException dioErorr) {
    switch (dioErorr.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFaliure(
            erorrMessage: "Connection Timeout With Api Server");

      case DioExceptionType.sendTimeout:
        return ServerFaliure(erorrMessage: "Send Timeout With Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerFaliure(erorrMessage: "Receive Timeout With Api Server");
      case DioExceptionType.badResponse:
        return ServerFaliure.fromResponse(
            dioErorr.response!.statusCode!, dioErorr.response);
      case DioExceptionType.cancel:
        return ServerFaliure(erorrMessage: "Request to Api Server Was Canceld");

      case DioExceptionType.unknown:
        if (dioErorr.message != null) {
          if (dioErorr.message!.contains('SocketException')) {
            return ServerFaliure(erorrMessage: "No InterNet Connection");
          }
        } else {
          return ServerFaliure(erorrMessage: "No InterNet Connection");
        }
        return ServerFaliure(erorrMessage: "Unexpected Erorr, Plase ty again!");
      default:
        return ServerFaliure(erorrMessage: "Opps There Was am Erorr");
    }
  }
  factory ServerFaliure.fromResponse(int stutusCode, dynamic response) {
    if (stutusCode == 401) {
      return ServerFaliure(
          erorrMessage: response.data['message'], statusCode: stutusCode);
    } else if (stutusCode == 400 || stutusCode == 403) {
      return ServerFaliure(erorrMessage: response.data['message']);
    } else if (stutusCode == 404) {
      return ServerFaliure(
          erorrMessage: "Your Request Not Found, Please try later!");
    } else if (stutusCode == 500) {
      return ServerFaliure(
          erorrMessage: "Internal Server Erorr, Please try later!");
    } else if (stutusCode == 422) {
      final Map<String, dynamic> decode = jsonDecode(response.toString());

      return ServerFaliure(erorrMessage: decode['message']);
    } else {
      return ServerFaliure(erorrMessage: "Opps There Was am Erorr");
    }
  }
}
