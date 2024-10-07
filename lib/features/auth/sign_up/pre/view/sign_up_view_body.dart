import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/profile.dart';
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
                  return "Name is Short".tr(context);
                } else if (value.isEmpty) {
                  return "Please Enter your name".tr(context);
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
                  return "Please Enter email".tr(context);
                } else {
                  return null;
                }
              },
            ),
            InternationalPhoneNumberInput(
              locale: UserData.lang,
              searchBoxDecoration: InputDecoration(
                  label: Text(
                      "search by country name or digital code".tr(context))),
              onInputChanged: (PhoneNumber number) {},
              onInputValidated: (bool value) {},
              inputDecoration: InputDecoration(
                  hintText: "enter_phone".tr(context),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "phone".tr(context),
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface),
                      )),
                  border: outlineInputBorder(context),
                  enabledBorder: outlineInputBorder(context),
                  focusedBorder: outlineInputBorder(context)),
              selectorConfig: const SelectorConfig(
                useEmoji: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              validator: (value) {
                if (value!.length < 9) {
                  return "phone number is Short".tr(context);
                }
                if (value.isEmpty) {
                  return "Please Enter your phone number".tr(context);
                } else {
                  return null;
                }
              },
              selectorTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
              // initialValue: number,
              textFieldController: signUpCubit.phoneController,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            SizedBox(
              height: 20,
            ), // CustomAuthTextFormFeild(
            //   hinttext: 'enter_phone'.tr(context),
            //   label: 'phone'.tr(context),
            //   iconData: Icons.phone,
            //   mycontroller: signUpCubit.phoneController,
            //   validator: (value) {
            //     if (value!.length < 9) {
            //       return "phone number is Short".tr(context);
            //     }
            //     if (value.isEmpty) {
            //       return "Please Enter your phone number".tr(context);
            //     } else {
            //       return null;
            //     }
            //   },
            // ),
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
                  return "password is Short".tr(context);
                } else if (value.isEmpty) {
                  return "Please Enter Password".tr(context);
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomBotton(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              textColor: Theme.of(context).colorScheme.surface,
              text: 'sign_up_now'.tr(context),
              onPressed: () {
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
