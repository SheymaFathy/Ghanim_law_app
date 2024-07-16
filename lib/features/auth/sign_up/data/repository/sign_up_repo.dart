import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import '../../../../../core/erorr/server_faliure.dart';
import '../model/get/sign_up_model.dart';
import '../model/set/set_sign_up_model.dart';

abstract class SignUpRepo {
  Future<Either<Faliure, SignUpModel>> fetchSignUp(SetSignUpModel data);
}

class SignUpRepoImp extends SignUpRepo {
  @override
  Future<Either<Faliure, SignUpModel>> fetchSignUp(SetSignUpModel data) async {
    try {
      final response =
          await DioHelper.postData(url: "api/register", data: data.toJson());

      return Right(SignUpModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
