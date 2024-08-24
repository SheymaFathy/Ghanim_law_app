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
            erorrMessage: "Connection Timeout With Api Server",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);

      case DioExceptionType.sendTimeout:
        return ServerFaliure(
            erorrMessage: "Send Timeout With Api Server",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);
      case DioExceptionType.receiveTimeout:
        return ServerFaliure(
            erorrMessage: "Receive Timeout With Api Server",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);
      case DioExceptionType.badResponse:
        return ServerFaliure.fromResponse(
            dioErorr.response!.statusCode!, dioErorr.response);
      case DioExceptionType.cancel:
        return ServerFaliure(
            erorrMessage: "Request to Api Server Was Canceld",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);

      case DioExceptionType.unknown:
        if (dioErorr.message != null) {
          if (dioErorr.message!.contains('SocketException')) {
            return ServerFaliure(
                erorrMessage: "No InterNet Connection",
                statusCode: dioErorr.response != null
                    ? dioErorr.response!.statusCode
                    : 0);
          }
        } else {
          return ServerFaliure(
              erorrMessage: "No InterNet Connection",
              statusCode: dioErorr.response != null
                  ? dioErorr.response!.statusCode
                  : 0);
        }
        return ServerFaliure(
            erorrMessage: "Unexpected Erorr, Plase ty again!",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);
      default:
        return ServerFaliure(
            erorrMessage: "Opps There Was am Erorr",
            statusCode:
                dioErorr.response != null ? dioErorr.response!.statusCode : 0);
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
