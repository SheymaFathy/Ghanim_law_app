import 'package:equatable/equatable.dart';

import 'errors.dart';

class ErorrSignUp extends Equatable {
  final String? message;
  final Errors? errors;

  const ErorrSignUp({this.message, this.errors});

  factory ErorrSignUp.fromJson(Map<String, dynamic> json) => ErorrSignUp(
        message: json['message'] as String?,
        errors: json['errors'] == null
            ? null
            : Errors.fromJson(json['errors'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'errors': errors?.toJson(),
      };

  @override
  List<Object?> get props => [message, errors];
}
