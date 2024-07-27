import 'package:equatable/equatable.dart';

import 'data.dart';

class MyOrderDetailsModel extends Equatable {
  final Data? data;

  const MyOrderDetailsModel({this.data});

  factory MyOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return MyOrderDetailsModel(
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
