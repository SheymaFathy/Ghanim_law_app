import 'package:equatable/equatable.dart';

class Paid extends Equatable {
  final int? price;
  final String? currency;
  final String? formatted;

  const Paid({this.price, this.currency, this.formatted});

  factory Paid.fromJson(Map<String, dynamic> json) => Paid(
        price: json['price'] as int?,
        currency: json['currency'] as String?,
        formatted: json['formatted'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'currency': currency,
        'formatted': formatted,
      };

  @override
  List<Object?> get props => [price, currency, formatted];
}
