import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/widget/custom_snackbar_widget.dart';

void loginMaterialBannerWidget(BuildContext context) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        customSnackBarWidget("login_sccess".tr(context), Colors.grey[800]!));
}
