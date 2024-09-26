import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';

import '../../../../../core/widget/auto_direction.dart';

class MyOrderDescriptionTextWidget extends StatelessWidget {
  const MyOrderDescriptionTextWidget({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRTL(description),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Text(
          description,
          textAlign: TextAlign.start,
          style: Styles.textStyle16,
        ),
      ),
    );
  }
}
