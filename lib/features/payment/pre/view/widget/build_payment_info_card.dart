import 'package:flutter/material.dart';

class BuildPaymentInfoCard extends StatelessWidget {
  const BuildPaymentInfoCard(
      {super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(5.0),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}
