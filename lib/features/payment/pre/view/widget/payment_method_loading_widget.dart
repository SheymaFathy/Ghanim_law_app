import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'custom_loading_payment.dart';

class PaymentMethodLoadingWidget extends StatelessWidget {
  const PaymentMethodLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingPayment(
      text: "Loading payment methods. Please wait.".tr(context),
    );
  }
}
