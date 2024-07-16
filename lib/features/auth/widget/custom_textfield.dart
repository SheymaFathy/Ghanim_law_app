import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class CustomAuthTextFormFeild extends StatelessWidget {
  final String hinttext;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final bool? obbscureText;
  final void Function()? onTapSuffix;
  final String? Function(String?)? validator;
  const CustomAuthTextFormFeild(
      {super.key,
      required this.hinttext,
      required this.label,
      required this.iconData,
      required this.mycontroller,
      this.obbscureText,
      this.onTapSuffix,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        obscureText: obbscureText ?? false,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 10, color: AppColors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
          label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                label,
                style: const TextStyle(fontSize: 15),
              )),
          suffixIcon: onTapSuffix != null
              ? IconButton(
                  onPressed: onTapSuffix,
                  icon: obbscureText!
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.remove_red_eye))
              : Icon(iconData),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
