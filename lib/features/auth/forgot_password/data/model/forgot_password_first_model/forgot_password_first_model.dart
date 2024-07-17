import 'package:equatable/equatable.dart';

import 'links.dart';

class ForgotPasswordFirstModel extends Equatable {
  final String? message;
  final Links? links;

  const ForgotPasswordFirstModel({this.message, this.links});

  factory ForgotPasswordFirstModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordFirstModel(
      message: json['message'] as String?,
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'links': links?.toJson(),
      };

  @override
  List<Object?> get props => [message, links];
}
