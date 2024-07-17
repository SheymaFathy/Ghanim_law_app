import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/widget/material_banner_success.dart';

void loginMaterialBannerWidget(BuildContext context) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(
        materialBannerSuccess("login".tr(context), "login".tr(context)));
}
