import 'package:equatable/equatable.dart';

import 'paid.dart';
import 'price.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic description;
  final String? type;
  final String? status;
  final dynamic rejectReason;
  final Price? price;
  final Paid? paid;
  final String? voice;
  final String? pdf;
  final List<dynamic>? documents;

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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        description: json['description'] as dynamic,
        type: json['type'] as String?,
        status: json['status'] as String?,
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'description': description,
        'type': type,
        'status': status,
        'reject_reason': rejectReason,
        'price': price?.toJson(),
        'paid': paid?.toJson(),
        'voice': voice,
        'pdf': pdf,
        'documents': documents,
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
    ];
  }
}
