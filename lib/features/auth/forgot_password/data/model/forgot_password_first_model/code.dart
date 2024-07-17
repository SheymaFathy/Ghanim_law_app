import 'package:equatable/equatable.dart';

class Code extends Equatable {
  final String? href;
  final String? method;

  const Code({this.href, this.method});

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        href: json['href'] as String?,
        method: json['method'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'href': href,
        'method': method,
      };

  @override
  List<Object?> get props => [href, method];
}
