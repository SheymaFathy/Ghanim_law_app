import 'package:equatable/equatable.dart';

class SetSignUpModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;
  // final String? cityId;
  // final String? type;
  // final File? file;

  SetSignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    // this.cityId,
    // this.type,
    // this.file
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        // "city_id": cityId,
        // "type": type,
        // "file": file,
      };
  @override
  List<Object?> get props => [
        name, email, phone, password,
        passwordConfirmation, // cityId, type, file,
      ];
}
