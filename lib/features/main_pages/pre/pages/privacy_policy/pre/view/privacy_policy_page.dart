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
            const Text('تم التحديث بتاريخ 24 / 07 /2024',
                style: Styles.textStyle14),
            const SizedBox(height: 16.0),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 16.0),
            const Text('المقدمة', style: Styles.textStyle18),
            const SizedBox(height: 8.0),
            const Text(
              'Welcome to our application. We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose your information.',
              style: Styles.textStyle14,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'سياسة المستخدمين',
              style: Styles.textStyle18,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'We may collect various types of information in connection with your use of our application, including:\n\n1. Personal information you provide to us directly.\n2. Information collected automatically through your use of our services.\n3. Information from third-party sources.',
              style: Styles.textStyle14,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'تواصل معنا',
              style: Styles.textStyle18,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you have any questions about this Privacy Policy, please contact us at support@example.com.',
              style: Styles.textStyle14,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
