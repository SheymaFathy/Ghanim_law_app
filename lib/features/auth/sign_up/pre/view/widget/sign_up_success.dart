import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../../core/widget/custom_snackbar_widget.dart';
import '../../view_model/cubit/sign_up_cubit.dart';

void signUpSuccessWidget(BuildContext context, SignUpState state) {
  EasyLoading.dismiss();
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBarWidget(
        state.signUpNewAccoutModel!.message!, Colors.grey[800]!));
}
