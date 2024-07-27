import 'package:flutter/material.dart';

import '../../../../../core/widget/auto_direction.dart';

class MyOrderDescriptionTextWidget extends StatelessWidget {
  const MyOrderDescriptionTextWidget({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRTL(description),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(description),
      ),
    );
  }
}
