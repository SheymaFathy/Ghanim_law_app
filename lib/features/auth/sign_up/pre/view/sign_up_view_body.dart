import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_text_signup_login.dart';
import '../../../widget/custom_textfield.dart';
import '../../data/model/set/set_sign_up_model.dart';
import '../view_model/cubit/sign_up_cubit.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody(
      {super.key, required this.signUpCubit, required this.state});

  final SignUpCubit signUpCubit;
  final SignUpState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Form(
        key: signUpCubit.formKey,
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
              validator: (value) {
                if (value!.length < 4) {
                  return "Name is Short";
                } else if (value.isEmpty) {
                  return "Please Enter your name";
                } else {
                  return null;
                }
              },
            ),
            CustomAuthTextFormFeild(
              hinttext: 'enter_email'.tr(context),
              label: 'email'.tr(context),
              iconData: Icons.email_outlined,
              mycontroller: signUpCubit.emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter email";
                } else {
                  return null;
                }
              },
            ),
            CustomAuthTextFormFeild(
              hinttext: 'enter_phone'.tr(context),
              label: 'phone'.tr(context),
              iconData: Icons.phone,
              mycontroller: signUpCubit.phoneController,
              validator: (value) {
                if (value!.length < 9) {
                  return "phone number is Short";
                }
                if (value.isEmpty) {
                  return "Please Enter your phone number";
                } else {
                  return null;
                }
              },
            ),
            CustomAuthTextFormFeild(
              hinttext: 'enter_pass'.tr(context),
              label: 'password'.tr(context),
              iconData: Icons.lock,
              mycontroller: signUpCubit.passwordController,
              onTapSuffix: () {
                signUpCubit.toggleObscure();
              },
              obbscureText: state.isObscure,
              validator: (value) {
                if (value!.length < 8) {
                  return "password is Short";
                } else if (value.isEmpty) {
                  return "Please Enter Password";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.grey,
              text: 'sign_up_now'.tr(context),
              onPressed: () {
                print(signUpCubit.nameController.text);
                signUpCubit.fetchSignUp(SetSignUpModel(
                    name: signUpCubit.nameController.text,
                    email: signUpCubit.emailController.text,
                    phone: signUpCubit.phoneController.text,
                    password: signUpCubit.passwordController.text,
                    passwordConfirmation: signUpCubit.passwordController.text));
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
      ),
    );
  }
}
