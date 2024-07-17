import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/widget/material_banner_success.dart';
import '../../view_model/cubit/sign_up_cubit.dart';
import '../sign_up_view_body.dart';

void signUpSuccessWidget(BuildContext context, SignUpState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBannerSuccess(
        state.signUpNewAccoutModel!.message!, "sign_up".tr(context)));
}
