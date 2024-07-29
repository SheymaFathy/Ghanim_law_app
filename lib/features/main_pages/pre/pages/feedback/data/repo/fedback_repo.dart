import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';

import '../../../../../../../core/dio/dio_helper.dart';

abstract class FedbackRepo {
  Future<Either<Faliure, String>> sendFeedBackMessage(
      Map<String, dynamic> data);
}

class FedbackRepoImp extends FedbackRepo {
  @override
  Future<Either<Faliure, String>> sendFeedBackMessage(
      Map<String, dynamic> data) async {
    try {
      final response =
          await DioHelper.postData(url: "/api/feedback", data: data);

      return Right(response.data['message']);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }
}
