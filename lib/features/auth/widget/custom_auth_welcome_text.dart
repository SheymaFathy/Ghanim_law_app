import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomTextWelcomeAuth extends StatelessWidget {
  final String welcometextbody;
  const CustomTextWelcomeAuth({super.key, required this.welcometextbody});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        textAlign: TextAlign.center,
        welcometextbody,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 13, color: AppColors.grey, fontWeight: FontWeight.normal),
      ),
    );
  }
}
