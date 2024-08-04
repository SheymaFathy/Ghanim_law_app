import 'package:equatable/equatable.dart';

import 'paid.dart';
import 'price.dart';
import 'status.dart';
import 'type.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic description;
  final Type? type;
  final Status? status;
  final dynamic rejectReason;
  final Price? price;
  final Paid? paid;
  final String? voice;
  final String? pdf;
  final List<dynamic>? documents;
  final List? images;

  const Datum({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.description,
    this.type,
    this.status,
    this.rejectReason,
    this.price,
    this.paid,
    this.voice,
    this.pdf,
    this.documents,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        description: json['description'] as dynamic,
        type: json['type'] == null
            ? null
            : Type.fromJson(json['type'] as Map<String, dynamic>),
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        rejectReason: json['reject_reason'] as dynamic,
        price: json['price'] == null
            ? null
            : Price.fromJson(json['price'] as Map<String, dynamic>),
        paid: json['paid'] == null
            ? null
            : Paid.fromJson(json['paid'] as Map<String, dynamic>),
        voice: json['voice'] as String?,
        pdf: json['pdf'] as String?,
        documents: json['documents'] as List<dynamic>?,
        images: json['images'] as List,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'description': description,
        'type': type?.toJson(),
        'status': status?.toJson(),
        'reject_reason': rejectReason,
        'price': price?.toJson(),
        'paid': paid?.toJson(),
        'voice': voice,
        'pdf': pdf,
        'documents': documents,
        'images': images,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      phone,
      description,
      type,
      status,
      rejectReason,
      price,
      paid,
      voice,
      pdf,
      documents,
      images,
    ];
  }
}
