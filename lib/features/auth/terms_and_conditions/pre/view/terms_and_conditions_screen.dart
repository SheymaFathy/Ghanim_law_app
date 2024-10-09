import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/responsive_text/app_style.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../privacy_policy/pre/view/privacy_policy_page.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool isChecked = false;
  toggleCheckbox() {
    isChecked = !isChecked;
    setState(() {});
  }

  @override
  initState() {
    getIt<HomeCubit>().getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('terms_and_privcy'.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 0.9),
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2)),
                  child: const PrivacyPolicyPage()),
            ),
            GestureDetector(
              onTap: () {
                toggleCheckbox();
              },
              child: Row(
                children: [
                  Checkbox(value: isChecked, onChanged: null),
                  Text(
                    "I agree to the rules and usage policy".tr(context),
                    style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 18)),
                  ),
                ],
              ),
            ),
            if (isChecked == true)
              CustomBotton(
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  textColor: Theme.of(context).colorScheme.surface,
                  text: "next".tr(context),
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kSignup);
                  })
          ],
        ),
      ),
    );
  }
}
