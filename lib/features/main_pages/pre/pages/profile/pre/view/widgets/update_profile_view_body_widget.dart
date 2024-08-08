import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../../../core/widget/custom_button.dart';
import '../../../../../../../../core/widget/global_textfield.dart';
import '../../../../../../../auth/widget/custom_auth_title.dart';
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
                  return "Please enter name";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              onChanged: (value) {
                profileCubit.checkValuesFormFiled(state.profileModel!);
                return null;
              },
              mycontroller: profileCubit.phoneController,
              hinttext: "enter_phone".tr(context),
              label: "phone".tr(context),
              iconData: Icons.person,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter phone number";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              onChanged: (value) {
                profileCubit.checkValuesFormFiled(state.profileModel!);
                return null;
              },
              mycontroller: profileCubit.emailController,
              hinttext: "enter_email".tr(context),
              label: "email".tr(context),
              iconData: Icons.person,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter email";
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
