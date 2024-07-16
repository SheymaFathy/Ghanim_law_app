import 'package:dartz/dartz.dart';
import 'package:ghanim_law_app/core/erorr/Exception.dart';
import 'package:ghanim_law_app/features/auth/login/data/model/login_model.dart';
import '../../../../../core/dio/dio_helper.dart';


abstract class LoginRepo {
  Future<Either<ServerException, LoginModel>> fetchLogin(
      String email, password);
}

class LoginRepoImp extends LoginRepo {
  @override
  Future<Either<ServerException, LoginModel>> fetchLogin(
      String email, password) async {
    final response = await DioHelper.postData(
        url: "/api/login", data: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      return Right(LoginModel.fromJson(response.data));
    } else {
      print(response);
      throw ServerException(erorrMessageModel: response.data['message']);
    }
  }
}
