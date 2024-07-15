import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomAuthContainer extends StatelessWidget {
  const CustomAuthContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: AppColors.primeryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
      child: const Icon(
        Icons.balance,
        color: AppColors.grey,
        size: 100,
      ),
    );
  }
}
