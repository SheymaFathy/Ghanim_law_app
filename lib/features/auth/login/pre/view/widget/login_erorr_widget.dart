import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../../core/widget/custom_snackbar_widget.dart';
import '../../view_model/cubit/login_cubit.dart';

void loginSnakeBarErorr(BuildContext context, LoginState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBarWidget(
        erorrMessage(state.loginErorrMessage, context), Colors.red));
}
