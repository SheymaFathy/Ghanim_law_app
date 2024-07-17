import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

void signUpLoadingWidget(context) async {
  await EasyLoading.show(
      status: 'loading...'.tr(context), maskType: EasyLoadingMaskType.black);
}
