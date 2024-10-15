import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/auto_direction.dart';

import '../../../../../core/widget/global_textfield.dart';
import '../../view_model/cubit/add_order_cubit.dart';

class PersonalFiledWidget extends StatelessWidget {
  const PersonalFiledWidget({
    super.key,
    required this.addOrderCubit,
  });

  final AddOrderCubit addOrderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextfield(
          mycontroller: addOrderCubit.nameController,
          textAlign: isArabic(addOrderCubit.nameController.text)
              ? TextAlign.right
              : TextAlign.left,
          hinttext: 'name'.tr(context),
          iconData: Icons.person,
          readOnly: addOrderCubit.paymentResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter name";
            } else {
              return null;
            }
          },
        ),
        GlobalTextfield(
          mycontroller: addOrderCubit.emailController,
          hinttext: 'email'.tr(context),
          iconData: Icons.email,
          textAlign: isArabic(addOrderCubit.nameController.text)
              ? TextAlign.right
              : TextAlign.left,
          textDirection: isArabic(addOrderCubit.nameController.text)
              ? TextDirection.rtl
              : TextDirection.ltr,
          readOnly: addOrderCubit.paymentResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter email";
            } else {
              return null;
            }
          },
        ),
        GlobalTextfield(
          textAlign: TextAlign.left,
          iconData: Icons.phone,
          textDirection: TextDirection.ltr,
          mycontroller: addOrderCubit.phoneController,
          hinttext: 'phone'.tr(context),
          readOnly: addOrderCubit.paymentResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter phone number";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
