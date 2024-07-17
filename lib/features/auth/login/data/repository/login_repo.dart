import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';

import 'package:ghanim_law_app/features/auth/login/data/model/login_model.dart';
import '../../../../../core/dio/dio_helper.dart';

abstract class LoginRepo {
  Future<Either<Faliure, LoginModel>> fetchLogin(String email, password);
}

class LoginRepoImp extends LoginRepo {
  @override
  Future<Either<Faliure, LoginModel>> fetchLogin(String email, password) async {
    try {
      final response = await DioHelper.postData(
          url: "/api/login", data: {'username': email, 'password': password});

      return Right(LoginModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
