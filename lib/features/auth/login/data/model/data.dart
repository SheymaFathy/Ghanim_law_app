import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? type;
  final String? avatar;
  final String? localedType;
  final String? createdAt;
  final String? createdAtFormatted;

  const Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.avatar,
    this.localedType,
    this.createdAt,
    this.createdAtFormatted,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        type: json['type'] as String?,
        avatar: json['avatar'] as String?,
        localedType: json['localed_type'] as String?,
        createdAt: json['created_at'] as String?,
        createdAtFormatted: json['created_at_formatted'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
        'avatar': avatar,
        'localed_type': localedType,
        'created_at': createdAt,
        'created_at_formatted': createdAtFormatted,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      phone,
      type,
      avatar,
      localedType,
      createdAt,
      createdAtFormatted,
    ];
  }
}
