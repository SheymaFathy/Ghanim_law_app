import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';

class OtpCodeScreen extends StatelessWidget {
  const OtpCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, '4getpass'.tr(context)),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: ListView(
            children: [
              CustomTextTitleAuth(
                title: "otp_code".tr(context),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextWelcomeAuth(
                welcometextbody: "otp_code_text".tr(context),
              ),
              const SizedBox(
                height: 50,
              ),
              OtpTextField(
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(15),
                numberOfFields: 5,
                borderColor: AppColors.primeryColor,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  //  controller.goToResetPass();
                }, // end onSubmit
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
