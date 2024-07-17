import 'package:equatable/equatable.dart';

import 'code.dart';

class Links extends Equatable {
  final Code? code;

  const Links({this.code});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        code: json['code'] == null
            ? null
            : Code.fromJson(json['code'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'code': code?.toJson(),
      };

  @override
  List<Object?> get props => [code];
}
