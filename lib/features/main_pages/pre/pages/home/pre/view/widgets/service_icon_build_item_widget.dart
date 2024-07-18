import 'package:flutter/material.dart';

class ServiceIconBuildItem extends StatelessWidget {
  const ServiceIconBuildItem({super.key, required this.serviceName});
  final String serviceName;
  @override
  Widget build(BuildContext context) {
    switch (serviceName) {
      case "legal_advice":
        return const Icon(Icons.gavel, size: 30);
      case "contract_review":
        return const Icon(Icons.description, size: 30);
      case "book_preparation":
        return const Icon(Icons.book, size: 30);
      default:
        return const Icon(Icons.abc);
    }
  }
}
