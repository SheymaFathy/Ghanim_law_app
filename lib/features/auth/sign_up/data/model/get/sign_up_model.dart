import 'package:equatable/equatable.dart';

import 'data.dart';

class SignUpModel extends Equatable {
  final Data? data;
  final String? token;
  final String? message;

  const SignUpModel({this.data, this.token, this.message});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        token: json['token'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'token': token,
        'message': message,
      };

  @override
  List<Object?> get props => [data, token, message];
}
