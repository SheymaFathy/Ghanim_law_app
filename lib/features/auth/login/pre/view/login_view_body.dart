import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_router.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_text_signup_login.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/logo.dart';
import '../view_model/cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.loginCubit,
  });

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginCubit.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: ListView(
          children: [
            const AuthLogo(),
            const SizedBox(
              height: 15,
            ),
            CustomTextTitleAuth(
              title: "welcome_back".tr(context),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextWelcomeAuth(
              welcometextbody: "welcome_text".tr(context),
            ),
            const SizedBox(
              height: 35,
            ),
            CustomAuthTextFormFeild(
              hinttext: 'enter_phone'.tr(context),
              label: 'phone'.tr(context),
              iconData: Icons.phone,
              mycontroller: loginCubit.userNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                } else {
                  return null;
                }
              },
            ),
            CustomAuthTextFormFeild(
              hinttext: 'enter_pass'.tr(context),
              label: 'password'.tr(context),
              iconData: Icons.lock,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else {
                  return null;
                }
              },
              mycontroller: loginCubit.passwordController,
            ),
            CustomTextSignUpOrLogIn(
              texttwo: "4get".tr(context),
              onTap: () {
                GoRouter.of(context).push(AppRouter.kForgetpassword);
              },
              textone: '',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.grey,
              text: 'login'.tr(context),
              onPressed: () {
                loginCubit.fetchLogin(loginCubit.userNameController.text,
                    loginCubit.passwordController.text);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextSignUpOrLogIn(
                textone: "no_account".tr(context),
                texttwo: "sign_up_now".tr(context),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kSignup);
                }),
          ],
        ),
      ),
    );
  }
}
