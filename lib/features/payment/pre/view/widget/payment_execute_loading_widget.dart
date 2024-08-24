import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/custom_loading_payment.dart';

class PaymentExecuteLoadingWidget extends StatelessWidget {
  const PaymentExecuteLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingPayment(
      text: "Initializing payment page.".tr(context),
    );
  }
}
