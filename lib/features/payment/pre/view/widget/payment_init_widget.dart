import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'custom_loading_payment.dart';

class PaymentInitWidget extends StatelessWidget {
  const PaymentInitWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingPayment(
      text: "Payment methods are being set up. Please wait.".tr(context),
    );
  }
}
