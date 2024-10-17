import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/build_payment_info_card.dart';
import 'package:myfatoorah_flutter/MFModels.dart';

import '../../../../../core/method/convert_datetime.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({
    super.key,
    required this.stateResponse,
  });

  final MFGetPaymentStatusResponse stateResponse;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: BuildPaymentInfoCard(
                    title: 'Invoice Number'.tr(context),
                    content: stateResponse.invoiceId?.toString() ??
                        'undefined'.tr(context)),
              ),
              Expanded(
                child: BuildPaymentInfoCard(
                    title: 'Invoice Status'.tr(context),
                    content:
                        stateResponse.invoiceStatus ?? 'undefined'.tr(context)),
              ),
              Expanded(
                child: BuildPaymentInfoCard(
                    title: 'Invoice Amount'.tr(context),
                    content: "${stateResponse.invoiceDisplayValue} "),
              )
            ],
          ),
          BuildPaymentInfoCard(
              title: 'Customer Name'.tr(context),
              content: stateResponse.customerName ?? 'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'phone'.tr(context),
              content: stateResponse.customerMobile ?? 'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'Customer Email'.tr(context),
              content: stateResponse.customerEmail ?? 'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'Invoice Reference'.tr(context),
              content:
                  stateResponse.invoiceReference ?? 'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'Creation Date'.tr(context),
              content: convertDateTime(stateResponse.createdDate.toString()) ??
                  'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'Expiration Date'.tr(context),
              content: stateResponse.expiryDate ?? 'undefined'.tr(context)),
          BuildPaymentInfoCard(
              title: 'Comments'.tr(context),
              content: stateResponse.comments ?? 'nothing'.tr(context)),
        ],
      ),
    );
  }
}
