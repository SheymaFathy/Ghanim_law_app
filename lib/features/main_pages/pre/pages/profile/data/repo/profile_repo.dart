import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/model/profile_model.dart';

import '../../../../../../../core/dio/dio_helper.dart';

abstract class ProfileRepo {
  Future<Either<Faliure, ProfileModel>> fetchProfileData();
}

class ProfileRepoImp extends ProfileRepo {
  @override
  Future<Either<Faliure, ProfileModel>> fetchProfileData() async {
    try {
      final response = await DioHelper.getData(
        url: "/api/profile",
      );

      return Right(ProfileModel.fromJson(response!.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
