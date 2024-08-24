import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_result_model/add_order_result_model.dart';

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
      // Upload Doc Files
      if (order.docs != null) {
        for (var file in order.docs!) {
          formData.files.add(MapEntry('documents[]',
              await MultipartFile.fromFile(file.path!, filename: file.name)));
        }
      }
      // Upload Doc Files
      // Upload Images Files
      if (order.image != null) {
        for (var file in order.image!) {
          // ignore: avoid_print
          print(file.name);
          formData.files.add(MapEntry('images[]',
              await MultipartFile.fromFile(file.path, filename: file.name)));
        }
      }
      // Upload Images Files
      // Upload Voice File
      print("Voice:${order.voice!.path}");
      if (order.voice != null) {
        formData.files.add(MapEntry(
            'voice',
            await MultipartFile.fromFile(order.voice!.path,
                filename: order.voice!.name,
                contentType: DioMediaType.parse("audio/wav"))));
      }
      // Upload Voice File
      // Upload description
      if (order.description != null) {
        formData.fields.add(MapEntry("description", order.description!));
      }
      // Upload description

      // Upload Person Information
      formData.fields.add(MapEntry("name", order.name!));
      formData.fields.add(MapEntry("email", order.email!));
      formData.fields.add(MapEntry("phone", order.phone!));
      formData.fields.add(MapEntry("type", order.typeOrder!));
      // Upload Person Information
      final response =
          await DioHelper.postData(url: "/api/orders", data: formData);

      return Right(AddOrderResultModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.type);
        print(e.message);
        print(e.error);
        print(e.response);
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }
}
