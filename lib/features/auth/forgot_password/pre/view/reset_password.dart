import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view_model/cubit/forgot_password_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotCubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
        appBar: myAppBar(context, 'new_password'.tr(context)),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextTitleAuth(
                title: "write_new_password".tr(context),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomAuthTextFormFeild(
                hinttext: 'write_new_password'.tr(context),
                label: 'password'.tr(context),
                iconData: Icons.lock,
                mycontroller: forgotCubit.passwordController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomAuthTextFormFeild(
                hinttext: 're_write_pass'.tr(context),
                label: 're_pass'.tr(context),
                iconData: Icons.lock,
                mycontroller: forgotCubit.rePasswordController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomBotton(
                backgroundColor: AppColors.primeryColor,
                textColor: AppColors.grey,
                text: 'continue_btn'.tr(context),
                onPressed: () {
                  // Get.toNamed(AppRoutes.navbar);
                },
              ),
            ],
          ),
        ));
  }
}
