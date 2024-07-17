import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/widget/snake_bar_erorr.dart';
import '../../view_model/cubit/login_cubit.dart';

void loginSnakeBarErorr(BuildContext context, LoginState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBarErorr(state.loginErorrMessage, "login".tr(context)));
}
