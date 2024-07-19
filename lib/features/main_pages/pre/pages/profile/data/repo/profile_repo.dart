import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/model/profile_model.dart';

import '../../../../../../../core/dio/dio_helper.dart';
import '../model/set/set_profile_data_model.dart';

abstract class ProfileRepo {
  Future<Either<Faliure, ProfileModel>> fetchProfileData();
  Future<Either<Faliure, ProfileModel>> updateProfile(SetProfileDataModel data);
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

  @override
  Future<Either<Faliure, ProfileModel>> updateProfile(
      SetProfileDataModel data) async {
    try {
      final response =
          await DioHelper.postData(url: "/api/profile", data: data.toJson());

      return Right(ProfileModel.fromJson(response.data));
    } on Exception catch (e) {
      print(e);
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
