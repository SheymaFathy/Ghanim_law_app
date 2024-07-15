import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/auth/login/pre/view/login_screen.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view_model/cubit/sign_up_cubit.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widget/app_bar.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_text_signup_login.dart';
import '../../../widget/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, 'sign_up'.tr(context)),
        body: BlocProvider(
          create: (context) => SignUpCubit(),
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {},
            builder: (context, state) {
              final signUpCubit = context.read<SignUpCubit>();
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextTitleAuth(
                      title: "welcome".tr(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextWelcomeAuth(
                      welcometextbody: "welcome_sign_up_text".tr(context),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomAuthTextFormFeild(
                      hinttext: 'enter_name'.tr(context),
                      label: 'name'.tr(context),
                      iconData: Icons.person,
                      mycontroller: signUpCubit.nameController,
                    ),
                    CustomAuthTextFormFeild(
                      hinttext: 'enter_email'.tr(context),
                      label: 'email'.tr(context),
                      iconData: Icons.email_outlined,
                      mycontroller: signUpCubit.emailController,
                    ),
                    CustomAuthTextFormFeild(
                      hinttext: 'enter_phone'.tr(context),
                      label: 'phone'.tr(context),
                      iconData: Icons.phone,
                      mycontroller: signUpCubit.phoneController,
                    ),
                    CustomAuthTextFormFeild(
                      hinttext: 'enter_pass'.tr(context),
                      label: 'password'.tr(context),
                      iconData: Icons.lock,
                      mycontroller: signUpCubit.passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomBotton(
                      backgroundColor: AppColors.primeryColor,
                      textColor: AppColors.grey,
                      text: 'sign_up_now'.tr(context),
                      onPressed: () {
                        //    controller.goToLogin();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextSignUpOrLogIn(
                        textone: "account".tr(context),
                        texttwo: "login_now".tr(context),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
