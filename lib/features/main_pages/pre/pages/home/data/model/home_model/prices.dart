import 'package:equatable/equatable.dart';

class PriceModel extends Equatable {
  final String serviceName;
  final int price;
  final String currency;
  final String formattedPrice;

  const PriceModel({
    required this.serviceName,
    required this.price,
    required this.currency,
    required this.formattedPrice,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json, String key) {
    return PriceModel(
      serviceName: key,
      price: json['price'] as int,
      currency: json['currency'] as String,
      formattedPrice: json['formatted'] as String,
    );
  }

  @override
  List<Object?> get props => [serviceName, price, currency, formattedPrice];
}
