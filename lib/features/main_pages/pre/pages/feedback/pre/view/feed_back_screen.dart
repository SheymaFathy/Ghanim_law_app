import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/logo.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "feedback".tr(context)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthLogo(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "feedback_title".tr(context),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GlobalTextfield(
                hinttext: "feedback_filed".tr(context),
                maxline: 10,
              ),
              // TextFormField(
              //   maxLines: 7,
              //   decoration: InputDecoration(
              //       border: const OutlineInputBorder(),
              //       hintStyle: const TextStyle(fontSize: 14),
              //       hintText: "feedback_filed".tr(context)),
              // ),
              const SizedBox(
                height: 20,
              ),
              CustomBotton(
                  backgroundColor: AppColors.primeryColor,
                  textColor: AppColors.backgroundColor,
                  text: "confirm".tr(context),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
