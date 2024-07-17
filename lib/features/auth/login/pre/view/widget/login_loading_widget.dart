import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

void loginLoadingWidget(BuildContext context) {
  EasyLoading.show(
      status: 'loading...'.tr(context), maskType: EasyLoadingMaskType.black);
}
