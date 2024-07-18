import 'package:equatable/equatable.dart';

import 'data.dart';

class ProfileModel extends Equatable {
  final Data? data;

  const ProfileModel({this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
