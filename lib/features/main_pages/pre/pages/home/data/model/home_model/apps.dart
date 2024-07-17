import 'package:equatable/equatable.dart';

class Apps extends Equatable {
  final String? apple;
  final String? android;

  const Apps({this.apple, this.android});

  factory Apps.fromJson(Map<String, dynamic> json) => Apps(
        apple: json['apple'] as String?,
        android: json['android'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'apple': apple,
        'android': android,
      };

  @override
  List<Object?> get props => [apple, android];
}
