import 'package:equatable/equatable.dart';

class Contacts extends Equatable {
  final String? facebook;
  final String? instagram;
  final String? snapchat;
  final String? twitter;
  final String? phone;
  final String? phone2;
  final String? email;
  final String? email2;
  final String? address;
  final String? poBox;

  const Contacts({
    this.facebook,
    this.instagram,
    this.snapchat,
    this.twitter,
    this.phone,
    this.phone2,
    this.email,
    this.email2,
    this.address,
    this.poBox,
  });

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        facebook: json['facebook'] as String?,
        instagram: json['instagram'] as String?,
        snapchat: json['snapchat'] as String?,
        twitter: json['twitter'] as String?,
        phone: json['phone'] as String?,
        phone2: json['phone2'] as String?,
        email: json['email'] as String?,
        email2: json['email2'] as String?,
        address: json['address'] as String?,
        poBox: json['po_box'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'facebook': facebook,
        'instagram': instagram,
        'snapchat': snapchat,
        'twitter': twitter,
        'phone': phone,
        'phone2': phone2,
        'email': email,
        'email2': email2,
        'address': address,
        'po_box': poBox,
      };

  @override
  List<Object?> get props {
    return [
      facebook,
      instagram,
      snapchat,
      twitter,
      phone,
      phone2,
      email,
      email2,
      address,
      poBox,
    ];
  }
}
