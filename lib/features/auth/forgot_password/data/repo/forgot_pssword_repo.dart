import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:ghanim_law_app/features/auth/forgot_password/data/model/forgot_password_first_model/forgot_password_first_model.dart';

import '../../../../../core/dio/dio_helper.dart';
import '../../../../../core/erorr/server_faliure.dart';

abstract class ForgotPsswordRepo {
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchForgotPassword(
      String userName);
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchGetRestPasswordCode(
      String userName, String code);
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchResetPassword(
    String password,
    String token,
  );
}

class ForgotPsswordRepoImp extends ForgotPsswordRepo {
  @override
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchForgotPassword(
      String userName) async {
    try {
      final response = await DioHelper.postData(
          url: "/api/password/forget", data: {'username': userName});
      return Right(ForgotPasswordFirstModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchGetRestPasswordCode(
      String userName, String code) async {
    try {
      final response = await DioHelper.postData(
          url: "/api/password/code",
          data: {'username': userName, "code": code});
      return Right(ForgotPasswordFirstModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Faliure, ForgotPasswordFirstModel>> fetchResetPassword(
      String password, String token) async {
    try {
      final response = await DioHelper.postData(
          url: "/api/password/reset",
          data: {
            'token': token,
            "password": password,
            "password_confirmation": password
          });
      return Right(ForgotPasswordFirstModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }
}
