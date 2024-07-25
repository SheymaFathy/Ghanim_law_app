import 'package:flutter/material.dart';

import '../../../../../core/widget/auto_direction.dart';

class MyOrderDescriptionTextWidget extends StatelessWidget {
  const MyOrderDescriptionTextWidget({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Directionality(
          textDirection: isRTL(description), child: Text(description)),
    );
  }
}
