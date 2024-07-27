import 'package:equatable/equatable.dart';

import 'data.dart';

class AddOrderResultModel extends Equatable {
  final Data? data;

  const AddOrderResultModel({this.data});

  factory AddOrderResultModel.fromJson(Map<String, dynamic> json) {
    return AddOrderResultModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [data];
}
