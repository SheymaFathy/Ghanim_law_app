import 'package:flutter/material.dart';

class CustomAttachedFile extends StatelessWidget {
  final String text;
  final Icon iconData;
  final void Function()? ontab;

  const CustomAttachedFile({
    super.key,
    required this.text,
    required this.iconData,
    this.ontab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), iconData],
        ),
      ),
    );
  }
}
