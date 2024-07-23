import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class GlobalTextfield extends StatelessWidget {
  final String hinttext;
  final String? label;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final bool? obbscureText;
  final void Function()? onTapSuffix;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int? maxline;

  const GlobalTextfield({
    super.key,
    required this.hinttext,
    this.label,
    this.iconData,
    this.mycontroller,
    this.obbscureText,
    this.onTapSuffix,
    this.onChanged,
    this.validator,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        maxLines: maxline,
        onChanged: onChanged,
        validator: validator,
        controller: mycontroller,
        obscureText: obbscureText ?? false, // Potential issue here
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14, color: AppColors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          label: label != null
              ? Text(label!, style: const TextStyle(fontSize: 15))
              : null,
          suffixIcon: onTapSuffix != null
              ? IconButton(
                  onPressed: onTapSuffix,
                  icon: obbscureText ?? false
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.remove_red_eye))
              : Icon(iconData), // Potential issue here
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
