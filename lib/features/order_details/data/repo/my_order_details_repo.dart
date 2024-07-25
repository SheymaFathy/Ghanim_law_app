import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/order_details/data/model/my_order_details_model/my_order_details_model.dart';

abstract class MyOrderDetailsRepo {
  Future<Either<Faliure, MyOrderDetailsModel>> fetchOrderDetailsById(int id);
}

class MyOrderDetailsRepoImp extends MyOrderDetailsRepo {
  @override
  Future<Either<Faliure, MyOrderDetailsModel>> fetchOrderDetailsById(
      int id) async {
    try {
      final response = await DioHelper.getData(url: "api/orders/$id");

      return Right(MyOrderDetailsModel.fromJson(response!.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
