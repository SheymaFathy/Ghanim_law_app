import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view_model/cubit/forgot_password_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widget/app_bar.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, '4getpass'.tr(context)),
        body: BlocProvider(
          create: (context) => ForgotPasswordCubit(),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              final forgotCubit = context.read<ForgotPasswordCubit>();

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: ListView(
                  children: [
                    CustomTextTitleAuth(
                      title: "checkphone".tr(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextWelcomeAuth(
                      welcometextbody: "check_text".tr(context),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomAuthTextFormFeild(
                      hinttext: 'enter_phone'.tr(context),
                      label: 'phone'.tr(context),
                      iconData: Icons.phone,
                      mycontroller: forgotCubit.phoneController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomBotton(
                      backgroundColor: AppColors.primeryColor,
                      textColor: AppColors.grey,
                      text: 'checkbtn'.tr(context),
                      onPressed: () {
                        // controller.goToOtpCode();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
