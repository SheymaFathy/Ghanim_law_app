import 'dart:io';

class SetProfileDataModel {
  final String method;
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String? passwordConfirmation;
  final File? avatar;

  SetProfileDataModel(
      {required this.method,
      required this.name,
      required this.email,
      required this.phone,
      this.password = '',
      this.passwordConfirmation = '',
      this.avatar});

  Map<String, dynamic> toJson() => {
        "_method": method,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
