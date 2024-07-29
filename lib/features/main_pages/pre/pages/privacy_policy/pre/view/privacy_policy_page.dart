import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'policy'.tr(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('policy'.tr(context), style: Styles.textStyle18),
            const SizedBox(height: 16.0),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 16.0),
            const Text('المحتوى', style: Styles.textStyle18),
            const SizedBox(height: 8.0),
            const Text(
              'Welcome to our application. We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose your information.',
              style: Styles.textStyle14,
            ),
          ],
        ),
      ),
    );
  }
}
