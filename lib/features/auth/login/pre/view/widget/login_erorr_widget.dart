import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../core/widget/custom_snackbar_widget.dart';
import '../../view_model/cubit/login_cubit.dart';

void loginSnakeBarErorr(BuildContext context, LoginState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBarWidget(state.loginErorrMessage, Colors.red));
}
