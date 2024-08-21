import 'package:flutter/material.dart';

class BuildPaymentInfoCard extends StatelessWidget {
  const BuildPaymentInfoCard(
      {super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(content),
          ],
        ),
      ),
    );
  }
}
