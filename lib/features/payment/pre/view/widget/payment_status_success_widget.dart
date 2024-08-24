import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../core/widget/custom_button.dart';
import '../../../data/model/invoice_model.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';
import 'payment_details_view.dart';

class PaymentStatusSuccessWidget extends StatelessWidget {
  const PaymentStatusSuccessWidget({
    super.key,
    required this.paymentMyFatorahModel,
    required this.state,
  });

  final PaymentMyFatorahModel paymentMyFatorahModel;
  final PaymentMyFatorahState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PaymentDetailsView(
                stateResponse: state.paymentStatusResponse!)),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: CustomBotton(
              borderRadius: BorderRadius.circular(12),
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              textColor: Theme.of(context).colorScheme.surface,
              text: "Checkout".tr(context),
              onPressed: () {
                context
                    .read<PaymentMyFatorahCubit>()
                    .executeRegularPayment(paymentMyFatorahModel, context);
              }),
        )
      ],
    );
  }
}
