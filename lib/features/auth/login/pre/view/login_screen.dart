import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view/sign_up_screen.dart';
import 'package:ghanim_law_app/features/auth/widget/logo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view/main_screen.dart';

import '../../../../../core/constants/app_colors.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/widget/app_bar.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../forgot_password/pre/view/forget_password_screen.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_text_signup_login.dart';
import '../../../widget/custom_textfield.dart';
import '../view_model/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          context,
          'login'.tr(context),
        ),
        body: BlocProvider(
          create: (context) => LoginCubit(getIt()),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              final loginCubit = context.read<LoginCubit>();
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Form(
                  key: loginCubit.formKey,
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
                            return "Please Enter Email Or phone Number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomAuthTextFormFeild(
                        hinttext: 'enter_pass'.tr(context),
                        label: 'password'.tr(context),
                        iconData: Icons.lock,
                        mycontroller: loginCubit.passwordController,
                        onTapSuffix: () {
                          loginCubit.toggleObscure();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          } else {
                            return null;
                          }
                        },
                        obbscureText: state.isObscure,
                      ),
                      CustomTextSignUpOrLogIn(
                        texttwo: "4get".tr(context),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
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
                          loginCubit.fetchLogin();
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MainScreen()),
                          //     (Route<dynamic> route) => false);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextSignUpOrLogIn(
                          textone: "no_account".tr(context),
                          texttwo: "sign_up_now".tr(context),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
