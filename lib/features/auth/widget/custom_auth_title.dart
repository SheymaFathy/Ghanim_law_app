import 'package:flutter/material.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String title;
  const CustomTextTitleAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),
    );
  }
}
