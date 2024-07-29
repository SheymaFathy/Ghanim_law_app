import 'package:equatable/equatable.dart';

class Type extends Equatable {
  final String? code;
  final String? label;

  const Type({this.code, this.label});

  factory Type.fromJson(Map<String, dynamic> json) => Type(
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
