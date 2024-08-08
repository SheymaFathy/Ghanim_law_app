import 'package:flutter/material.dart';

class CustomAboutUsContainer extends StatelessWidget {
  final String title;
  final IconData? iconData;
  const CustomAboutUsContainer({
    super.key,
    required this.title,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
