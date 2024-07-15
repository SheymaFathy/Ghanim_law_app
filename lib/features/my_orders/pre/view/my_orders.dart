import 'package:flutter/material.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('my_order'.tr(context), style: const TextStyle(fontSize: 24)),
    );
  }
}
