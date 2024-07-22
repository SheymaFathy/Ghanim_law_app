import 'package:flutter/material.dart';

import '../../../../../../../../core/constants/app_colors.dart';

class CustomAttachedFile extends StatelessWidget {
  final String text;
  final Icon iconData;
  final void Function()? ontab;
  final void Function()? onPressedIcon;
  const CustomAttachedFile(
      {super.key,
      required this.text,
      required this.iconData,
      this.ontab,
      this.onPressedIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primeryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            IconButton(onPressed: onPressedIcon, icon: iconData),
          ],
        ),
      ),
    );
  }
}
