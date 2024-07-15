import 'package:flutter/material.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('home'.tr(context), style: const TextStyle(fontSize: 24)),
    );
  }
}
