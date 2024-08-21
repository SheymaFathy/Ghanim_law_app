import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/build_payment_info_card.dart';
import 'package:myfatoorah_flutter/MFModels.dart';

import '../../../../../core/method/convert_datetime.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({
    super.key,
    required this.stateResponse,
  });

  final MFGetPaymentStatusResponse stateResponse;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: BuildPaymentInfoCard(
                  title: 'Invoice Number',
                  content: stateResponse.invoiceId?.toString() ?? 'غير محدد'),
            ),
            Expanded(
              child: BuildPaymentInfoCard(
                  title: 'Invoice Status',
                  content: stateResponse.invoiceStatus ?? 'غير محدد'),
            ),
            Expanded(
              child: BuildPaymentInfoCard(
                  title: 'Invoice Amount',
                  content: stateResponse.invoiceDisplayValue?.toString() ??
                      'غير محدد'),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: BuildPaymentInfoCard(
                  title: 'Customer Email',
                  content: stateResponse.customerEmail ?? 'غير محدد'),
            ),
            Expanded(
              child: BuildPaymentInfoCard(
                  title: 'Customer Name',
                  content: stateResponse.customerName ?? 'غير محدد'),
            ),
          ],
        ),
        BuildPaymentInfoCard(
            title: 'Invoice Reference',
            content: stateResponse.invoiceReference ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'Creation Date',
            content: convertDateTime(stateResponse.createdDate.toString()) ??
                'غير محدد'),
        BuildPaymentInfoCard(
            title: 'Expiration Date',
            content: stateResponse.expiryDate ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'Comments', content: stateResponse.comments ?? 'لا توجد'),
        BuildPaymentInfoCard(
            title: 'Customer Phone Number',
            content: stateResponse.customerMobile ?? 'غير محدد'),
      ],
    );
  }
}
