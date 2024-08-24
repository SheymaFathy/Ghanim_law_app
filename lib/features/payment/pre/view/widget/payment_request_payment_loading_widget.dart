import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/custom_loading_payment.dart';

class PaymentRequestPaymentLoadingWidget extends StatelessWidget {
  const PaymentRequestPaymentLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingPayment(
      text: "Processing your payment request.".tr(context),
    );
  }
}
