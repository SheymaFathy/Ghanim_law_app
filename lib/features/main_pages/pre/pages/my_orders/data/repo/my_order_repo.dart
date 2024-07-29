import 'package:dartz/dartz.dart';

import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/data/model/my_order_model/my_order_model.dart';

abstract class MyOrderRepo {
  Future<Either<Faliure, MyOrderModel>> fetchOrdersData();
}

class MyOrderRepoImp extends MyOrderRepo {
  @override
  Future<Either<Faliure, MyOrderModel>> fetchOrdersData() async {
    try {
      final reponse = await DioHelper.getData(url: "api/orders");
      return Right(MyOrderModel.fromJson(reponse!.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }
}
