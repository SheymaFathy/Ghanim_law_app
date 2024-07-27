import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/data/model/my_order_model/my_order_model.dart';

import '../../../../../../../core/dio/dio_helper.dart';

abstract class MyOrderRepo {
Future<Either<Faliure, List<MyOrderModel>>> fetchMyOrders();
}


class MyOrderRepoIml extends MyOrderModel {
  Future<Either<Faliure, MyOrderModel>> fetchMyOrders() async {
    try {
      final response = await DioHelper.getData(
        url: "/api/orders",
      );
      return Right(MyOrderModel.fromJson(response!.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}