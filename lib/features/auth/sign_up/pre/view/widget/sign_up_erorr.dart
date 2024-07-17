import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/widget/snake_bar_erorr.dart';
import '../../view_model/cubit/sign_up_cubit.dart';

void signUpErorrWidget(BuildContext context, SignUpState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBarErorr(
        state.signUpNewAccoutErorrMessage, "sign_up".tr(context)));
}
