import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../../../../core/profile.dart';
import '../../../../../../../../core/widget/custom_button.dart';
import '../../../../../../../../core/widget/global_textfield.dart';
import '../../../../../../../auth/widget/custom_auth_title.dart';
import '../../../../../../../auth/widget/custom_textfield.dart';
import '../../view_model/cubit/profile_cubit.dart';

class UpdateProfileViewBodyWidget extends StatelessWidget {
  const UpdateProfileViewBodyWidget(
      {super.key, required this.profileCubit, required this.state});

  final ProfileCubit profileCubit;
  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileCubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            CustomTextTitleAuth(title: 'edit_profile'.tr(context)),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              mycontroller: profileCubit.nameController,
              hinttext: "enter_name".tr(context),
              label: "name".tr(context),
              iconData: Icons.person,
              onChanged: (value) {
                profileCubit.checkValuesFormFiled(state.profileModel!);
                return null;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter_name".tr(context);
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InternationalPhoneNumberInput(
              locale: UserData.lang,
              searchBoxDecoration: InputDecoration(
                  label: Text(
                      "search by country name or digital code".tr(context))),
              onInputChanged: (PhoneNumber number) {
                profileCubit.checkValuesFormFiled(state.profileModel!);
                profileCubit.togglePhoneNumber(number);
              },
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
              countrySelectorScrollControlled: true,
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
              initialValue: state.phoneNumber ?? profileCubit.phoneNumber,
              textFieldController: profileCubit.phoneController,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
              onSaved: (PhoneNumber number) {},
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              textAlign: TextAlign.left,
              onChanged: (value) {
                profileCubit.checkValuesFormFiled(state.profileModel!);
                return null;
              },
              mycontroller: profileCubit.emailController,
              hinttext: "enter_email".tr(context),
              label: "email".tr(context),
              iconData: Icons.email,
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter_email".tr(context);
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            if (state.checkValuesFormFiled)
              CustomBotton(
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  textColor: Theme.of(context).colorScheme.surface,
                  text: "confirm".tr(context),
                  onPressed: () {
                    profileCubit.updateProfile();
                  })
          ],
        ),
      ),
    );
  }
}
