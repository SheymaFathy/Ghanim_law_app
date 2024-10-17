// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/erorr/server_faliure.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_model.dart';
import 'package:ghanim_law_app/features/order_form/data/model/add_order_result_model/add_order_result_model.dart';
import 'package:ghanim_law_app/features/payment/data/model/paid_model/paid_model.dart';

abstract class AddOrderRepo {
  Future<Either<Faliure, AddOrderResultModel>> fetchAddOrder(
    AddOrderModel order,
  );
  Future<Either<Faliure, PaidModel>> fetchPaidOrder(
      {required String orderID, required String invoiceId});
}

class AddOrderRepoImp extends AddOrderRepo {
  @override
  Future<Either<Faliure, AddOrderResultModel>> fetchAddOrder(
    AddOrderModel order,
  ) async {
    try {
      FormData formData = FormData();
      // Upload Doc Files
      if (order.docs != null) {
        var docsCopy = List.from(order.docs!);
        for (var file in docsCopy) {
          formData.files.add(MapEntry('documents[]',
              await MultipartFile.fromFile(file.path!, filename: file.name)));
        }
      }
      // Upload Doc Files
      // Upload Images Files
      if (order.image != null) {
        // قم بإنشاء نسخة من قائمة الصور للتكرار عليها
        var imageCopy = List.from(order.image!);

        for (var file in imageCopy) {
          // ignore: avoid_print
          print(file.name);
          formData.files.add(MapEntry('images[]',
              await MultipartFile.fromFile(file.path, filename: file.name)));
        }
      }
      // Upload Images Files
      // Upload Voice File
      if (order.voice != null) {
        formData.files.add(MapEntry(
            'voice',
            await MultipartFile.fromFile(order.voice!.path,
                filename: order.voice!.name)));
        // formData.files.add(MapEntry(
        //     'voice',
        //     await MultipartFile.fromFile(order.voice!.path,
        //         filename: order.voice!.name,
        //         contentType: DioMediaType.parse("audio/aac"))));
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
      //  print(formData.)
      print(response.statusCode);
      return Right(AddOrderResultModel.fromJson(response.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Faliure, PaidModel>> fetchPaidOrder(
      {required String orderID, required String invoiceId}) async {
    print(orderID);
    print(invoiceId);
    try {
      final response =
          await DioHelper.postData(url: "/api/orders/$orderID/checkout", data: {
        "invoice_id": invoiceId,
      });
      return Right(PaidModel.fromJson(response.data));
    } on Exception catch (e) {
      print(e);
      if (e is DioException) {
        return Left(ServerFaliure.fromDioErorr(e));
      } else {
        return Left(ServerFaliure(erorrMessage: e.toString()));
      }
    }
  }
}
