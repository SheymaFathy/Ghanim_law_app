import 'package:equatable/equatable.dart';

import 'data.dart';

class LoginModel extends Equatable {
  final Data? data;
  final String? token;

  const LoginModel({this.data, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'token': token,
      };

  @override
  List<Object?> get props => [data, token];
}
