import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_erorr_page_widget.dart';
import '../../../../core/widget/custom_snackbar_widget.dart';
import '../../data/model/invoice_model.dart';
import '../view_model/cubit/payment_my_fatorah_cubit.dart';
import 'widget/payment_details_view.dart';
import 'widget/payment_methods_list.dart';

class PaymentMyFatorahScreen extends StatelessWidget {
  const PaymentMyFatorahScreen(
      {super.key, required this.paymentMyFatorahModel});
  final PaymentMyFatorahModel paymentMyFatorahModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Select payment method'), centerTitle: true),
      body: BlocProvider(
        create: (context) => PaymentMyFatorahCubit()
          ..initiApi(num.parse(paymentMyFatorahModel.price)),
        child: BlocConsumer<PaymentMyFatorahCubit, PaymentMyFatorahState>(
          listener: (context, state) async {
            if (state.paymentSendState == PaymentState.executePaymentSuccess) {
              await Future.delayed(const Duration(seconds: 5)).then((onValue) {
                getIt<AddOrderCubit>().paymetnResponse =
                    state.executePaymentResponse;
                GoRouter.of(context).pop();
              });
            } else if (state.paymentSendState == PaymentState.paymentErorr) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    customSnackBarWidget(state.erorrMessage, Colors.red));
            }
          },
          builder: (context, state) {
            switch (state.paymentSendState) {
              case PaymentState.init:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("جاري تهيئة طرق الدفع برجاء الانتظار")
                  ],
                );
              case PaymentState.methodsPaymentLoading:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("يجري تحميل طرق الدفع برجاء الانتظار")
                  ],
                );
              case PaymentState.methodsPaymentSuccess:
                return PaymentMethodsList(paymentMyFatorahModel);
              case PaymentState.requestPaymentLoading:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("يجري تهيئة طلب الدفع")
                  ],
                );
              case PaymentState.requestPaymentSuccess:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("تم تهيئة طلب الدفع بنجاح جاري عرض تفاصيل الاوردر")
                  ],
                );
              case PaymentState.statusPaymentLoading:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("يجري تهيئة حالة الطلب")
                  ],
                );
              case PaymentState.statusPaymentSuccess:
                return Column(
                  children: [
                    Expanded(child: PaymentDetailsView(state: state)),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: CustomBotton(
                          borderRadius: BorderRadius.circular(12),
                          backgroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          textColor: Theme.of(context).colorScheme.surface,
                          text: "أكمال الدفع",
                          onPressed: () {
                            context
                                .read<PaymentMyFatorahCubit>()
                                .executeRegularPayment(paymentMyFatorahModel);
                          }),
                    )
                  ],
                );

              case PaymentState.executePaymentLoading:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text("يجري تهيئة صفحة الدفع")
                  ],
                );
              case PaymentState.executePaymentSuccess:
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text(
                        "تمت عملية الدفع بنجاح انتظر قليلاً وسيتم توجيهك الي صفحة ارسال الطلب")
                  ],
                );
              case PaymentState.paymentErorr:
                return CustomErorrPageWidget(
                  errorMessage: state.erorrMessage,
                  onTap: () {},
                );
            }
          },
        ),
      ),
    );
  }
}
