import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/custom_loading_payment.dart';

class PaymentStatusLoadingWidget extends StatelessWidget {
  const PaymentStatusLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingPayment(
      text: "Initializing order status.".tr(context),
    );
  }
}
