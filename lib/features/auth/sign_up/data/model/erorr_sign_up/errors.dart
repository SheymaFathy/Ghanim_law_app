import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String>? email;
  final List<String>? phone;
  final List<String>? password;

  const Errors({this.email, this.phone, this.password});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json['email'] as List<String>?,
        phone: json['phone'] as List<String>?,
        password: json['password'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'password': password,
      };

  @override
  List<Object?> get props => [email, phone, password];
}
