import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../../core/widget/custom_snackbar_widget.dart';
import '../../view_model/cubit/sign_up_cubit.dart';

void signUpErorrWidget(BuildContext context, SignUpState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBarWidget(
        erorrMessage(state.signUpNewAccoutErorrMessage, context), Colors.red));
}
