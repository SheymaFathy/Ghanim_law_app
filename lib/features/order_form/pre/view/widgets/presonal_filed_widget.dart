import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

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
          hinttext: 'name'.tr(context),
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
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter email";
            } else {
              return null;
            }
          },
        ),
        GlobalTextfield(
          mycontroller: addOrderCubit.phoneController,
          hinttext: 'phone'.tr(context),
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
