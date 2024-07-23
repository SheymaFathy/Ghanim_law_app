import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class CustomAboutUsContainer extends StatelessWidget {
  final String title;
  final IconData?  iconData;
  const CustomAboutUsContainer({
    super.key, required this.title, this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical:5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // grey shadow with opacity
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: AppColors.backgroundColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Icon(iconData),
        ],
      ),
    );
  }
}