import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/build_payment_info_card.dart';

import '../../../../../core/method/convert_datetime.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({
    super.key,
    required this.state,
  });

  final PaymentMyFatorahState state;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BuildPaymentInfoCard(
            title: 'رقم الفاتورة:',
            content: state.paymentStatusResponse!.invoiceId?.toString() ??
                'غير محدد'),
        BuildPaymentInfoCard(
            title: 'حالة الفاتورة:',
            content: state.paymentStatusResponse!.invoiceStatus ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'مرجع الفاتورة:',
            content:
                state.paymentStatusResponse!.invoiceReference ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'مرجع العميل:',
            content:
                state.paymentStatusResponse!.customerReference ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'تاريخ الإنشاء:',
            content: convertDateTime(
                    state.paymentStatusResponse!.createdDate.toString()) ??
                'غير محدد'),
        BuildPaymentInfoCard(
            title: 'تاريخ الانتهاء:',
            content: state.paymentStatusResponse!.expiryDate ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'قيمة الفاتورة:',
            content: state.paymentStatusResponse!.invoiceValue?.toString() ??
                'غير محدد'),
        BuildPaymentInfoCard(
            title: 'التعليقات:',
            content: state.paymentStatusResponse!.comments ?? 'لا توجد'),
        BuildPaymentInfoCard(
            title: 'اسم العميل:',
            content: state.paymentStatusResponse!.customerName ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'رقم جوال العميل:',
            content: state.paymentStatusResponse!.customerMobile ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'بريد العميل الإلكتروني:',
            content: state.paymentStatusResponse!.customerEmail ?? 'غير محدد'),
        BuildPaymentInfoCard(
            title: 'عرض قيمة الفاتورة:',
            content:
                state.paymentStatusResponse!.invoiceDisplayValue ?? 'غير محدد'),
      ],
    );
  }
}
