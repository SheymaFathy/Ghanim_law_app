import 'package:flutter/material.dart';

class CustomLoadingPayment extends StatelessWidget {
  const CustomLoadingPayment({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: CircularProgressIndicator()),
        const SizedBox(
          height: 5,
        ),
        Text(text)
      ],
    );
  }
}
