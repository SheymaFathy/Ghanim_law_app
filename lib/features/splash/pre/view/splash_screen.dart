import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../auth/widget/custom_auth_welcome_text.dart';
import '../../../auth/widget/logo.dart';
import '../../../main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AuthLogo(),
              const SizedBox(
                height: 15,
              ),
              CustomTextWelcomeAuth(
                welcometextbody: "splash_welcome_text".tr(context),
              ),
              const Spacer(),
              const ChangeLanguageColumn(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeLanguageColumn extends StatelessWidget {
  const ChangeLanguageColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '1'.tr(context),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.grey,
              text: 'arabic'.tr(context),
              onPressed: () {
                context.read<SettingCubit>().changeLanguage("ar");
              },
            ),
            const SizedBox(
              height: 15,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.grey,
              text: 'english'.tr(context),
              onPressed: () {
                context.read<SettingCubit>().changeLanguage("en");
              },
            ),
          ],
        ),
      ),
    );
  }
}
