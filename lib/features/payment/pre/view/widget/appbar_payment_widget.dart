import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/responsive_text/app_style.dart';

import '../../view_model/cubit/payment_my_fatorah_cubit.dart';

AppBar appBarPayment(PaymentMyFatorahState state, BuildContext context) {
  bool shouldShowBackButton() {
    return !(state.paymentSendState == PaymentState.executePaymentLoading ||
        state.paymentSendState == PaymentState.executePaymentSuccess);
  }

  String getAppBarTitle() {
    switch (state.paymentSendState) {
      case PaymentState.methodsPaymentLoading:
      case PaymentState.methodsPaymentSuccess:
        return 'Select payment method'.tr(context);
      case PaymentState.statusPaymentLoading:
      case PaymentState.statusPaymentSuccess:
        return "Payment Details".tr(context);
      case PaymentState.executePaymentLoading:
        return "Payment is being completed".tr(context);
      case PaymentState.executePaymentSuccess:
        return "The payment was completed successfully".tr(context);
      default:
        return "";
    }
  }

  return AppBar(
    automaticallyImplyLeading: shouldShowBackButton(),
    title: Text(
      getAppBarTitle(),
      style: TextStyle(fontSize: getResponsiveFontSize(context, fontSize: 18)),
    ),
    centerTitle: true,
  );
}
