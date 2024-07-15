import 'package:flutter/material.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('my_order'.tr(context), style: const TextStyle(fontSize: 24)),
    );
  }
}
