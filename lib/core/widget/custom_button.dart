import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton(
      {super.key,
      required this.backgroundColor,
      required this.textColor,
      this.borderRadius,
      required this.text,
      this.fontSize,
      required this.onPressed});

  final Color backgroundColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String text;
  final double? fontSize;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(15))),
        child: Text(
          text,
          style: Styles.textStyle14.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
