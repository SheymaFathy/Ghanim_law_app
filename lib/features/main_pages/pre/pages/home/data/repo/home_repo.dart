import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/model/home_model/home_model.dart';

import '../../../../../../../core/dio/dio_helper.dart';

abstract class HomeRepoRepo {
  Future<Either<Faliure, HomeModel>> fetchHomeData();
}

class HomeRepoRepoImp extends HomeRepoRepo {
  @override
  Future<Either<Faliure, HomeModel>> fetchHomeData() async {
    try {
      final response = await DioHelper.getData(
        url: "/api/settings",
      );

      return Right(HomeModel.fromJson(response!.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
