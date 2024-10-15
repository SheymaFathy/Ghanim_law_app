import 'package:equatable/equatable.dart';

import 'paid.dart';
import 'price.dart';
import 'status.dart';
import 'type.dart';

class Data extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final Type? type;
  final Status? status;
  final dynamic rejectReason;
  final Price? price;
  final Paid? paid;
  final String? invoiceId;
  final String? voice;
  final String? pdf;
  final List<dynamic>? documents;
  final List<dynamic>? images;

  const Data({
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
    this.invoiceId,
    this.voice,
    this.pdf,
    this.documents,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        description: json['description'] as String?,
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
        invoiceId: json['invoice_id'] as String?,
        voice: json['voice'] as String?,
        pdf: json['pdf'] as String?,
        documents: json['documents'] as List<dynamic>?,
        images: json['images'] as List<dynamic>?,
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
        'invoice_id': invoiceId,
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
      invoiceId,
      voice,
      pdf,
      documents,
      images,
    ];
  }
}
