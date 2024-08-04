import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final String? code;
  final String? label;

  const Status({this.code, this.label});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json['code'] as String?,
        label: json['label'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'label': label,
      };

  @override
  List<Object?> get props => [code, label];
}
