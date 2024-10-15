import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../data/model/invoice_model.dart';
import 'payment_details_view.dart';

class PaymentStatusSuccessWidget extends StatelessWidget {
  const PaymentStatusSuccessWidget({
    super.key,
    required this.paymentMyFatorahModel,
    required this.state,
  });

  final PaymentMyFatorahModel paymentMyFatorahModel;
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PaymentDetailsView(
                stateResponse: state.paymentStatusResponse!)),
        if (state.paymentSendState != PaymentState.executePaymentLoading)
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: CustomBotton(
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                textColor: Theme.of(context).colorScheme.surface,
                text: "continue_payment".tr(context),
                onPressed: () {
                  getIt<AddOrderCubit>()
                      .executeRegularPayment(paymentMyFatorahModel, context);
                }),
          )
      ],
    );
  }
}
