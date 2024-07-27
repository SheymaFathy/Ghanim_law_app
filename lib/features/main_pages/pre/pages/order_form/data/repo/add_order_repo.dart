import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/data/model/add_order_result_model/add_order_result_model.dart';

abstract class AddOrderRepo {
  Future<Either<Faliure, AddOrderResultModel>> fetchAddOrder(
      AddOrderModel order);
}

class AddOrderRepoImp extends AddOrderRepo {
  @override
  Future<Either<Faliure, AddOrderResultModel>> fetchAddOrder(
      AddOrderModel order) async {
    try {
      FormData formData = FormData();
      if (order.docs != null) {
        for (var file in order.docs!) {
          formData.files.add(MapEntry('documents[]',
              await MultipartFile.fromFile(file.path!, filename: file.name)));
        }
      }

      if (order.voice != null) {
        formData.files.add(MapEntry(
            'voice',
            await MultipartFile.fromFile(order.voice!.path,
                filename: order.voice!.name,
                contentType: DioMediaType.parse("audio/aac"))));
      }
      if (order.description != null) {
        formData.fields.add(MapEntry("description", order.description!));
      }

      formData.fields.add(MapEntry("name", order.name!));
      formData.fields.add(MapEntry("email", order.email!));
      formData.fields.add(MapEntry("phone", order.phone!));
      formData.fields.add(MapEntry("type", order.typeOrder!));

      final response =
          await DioHelper.postData(url: "/api/orders", data: formData);
      return Right(AddOrderResultModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(e.toString()));
      }
    }
  }
}
