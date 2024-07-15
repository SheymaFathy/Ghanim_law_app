import 'package:flutter/material.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('profile'.tr(context), style: const TextStyle(fontSize: 24)),
    );
  }
}
