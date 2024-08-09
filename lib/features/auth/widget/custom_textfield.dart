import 'package:flutter/material.dart';

class CustomAuthTextFormFeild extends StatelessWidget {
  final String hinttext;
  final String label;
  final IconData iconData;
  final TextEditingController mycontroller;
  final bool? obbscureText;
  final void Function()? onTapSuffix;
  final String? Function(String?)? validator;
  final double? marginBottom;
  const CustomAuthTextFormFeild(
      {super.key,
      required this.hinttext,
      required this.label,
      required this.iconData,
      required this.mycontroller,
      this.obbscureText,
      this.onTapSuffix,
      this.validator,
      this.marginBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? 20),
      child: TextFormField(
        validator: validator,
        controller: mycontroller,
        obscureText: obbscureText ?? false,
        decoration: InputDecoration(
            hintText: hinttext,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface),
                )),
            suffixIcon: onTapSuffix != null
                ? IconButton(
                    onPressed: onTapSuffix,
                    icon: obbscureText!
                        ? const Icon(Icons.lock)
                        : const Icon(Icons.remove_red_eye))
                : Icon(iconData),
            border: outlineInputBorder(context),
            enabledBorder: outlineInputBorder(context),
            focusedBorder: outlineInputBorder(context)),
      ),
    );
  }
}

outlineInputBorder(context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface));
