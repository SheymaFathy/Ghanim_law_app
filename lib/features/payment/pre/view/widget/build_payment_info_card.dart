import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/responsive_text/app_style.dart';

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
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          getResponsiveFontSize(context, fontSize: 17.5))),
            ),
            Text(content,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: getResponsiveFontSize(context, fontSize: 16.5))),
          ],
        ),
      ),
    );
  }
}
