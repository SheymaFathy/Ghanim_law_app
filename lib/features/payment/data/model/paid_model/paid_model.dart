import 'package:equatable/equatable.dart';

import 'data.dart';

class PaidModel extends Equatable {
  final Data? data;

  const PaidModel({this.data});

  factory PaidModel.fromJson(Map<String, dynamic> json) => PaidModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [data];
}
