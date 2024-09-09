import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/custom_erorr_page_widget.dart';
import '../../../../core/widget/custom_snackbar_widget.dart';
import '../../data/model/invoice_model.dart';
import '../view_model/cubit/payment_my_fatorah_cubit.dart';

import 'widget/appbar_payment_widget.dart';
import 'widget/payment_execute_loading_widget.dart';
import 'widget/payment_execute_success_widget.dart';
import 'widget/payment_init_widget.dart';
import 'widget/payment_method_loading_widget.dart';
import 'widget/payment_methods_list.dart';
import 'widget/payment_request_payment_loading_widget.dart';
import 'widget/payment_request_payment_success_widget.dart';
import 'widget/payment_status_loading_widget.dart';
import 'widget/payment_status_success_widget.dart';

class PaymentMyFatorahScreen extends StatelessWidget {
  const PaymentMyFatorahScreen(
      {super.key, required this.paymentMyFatorahModel});
  final PaymentMyFatorahModel paymentMyFatorahModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PaymentMyFatorahCubit>()..init(paymentMyFatorahModel),
      child: BlocConsumer<PaymentMyFatorahCubit, PaymentMyFatorahState>(
        bloc: getIt<PaymentMyFatorahCubit>(),
        listener: (context, state) async {
          if (state.paymentSendState == PaymentState.executePaymentSuccess) {
            await Future.delayed(const Duration(seconds: 5)).then((onValue) {});
          } else if (state.paymentSendState == PaymentState.paymentErorr) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  customSnackBarWidget(state.erorrMessage, Colors.red));
            getIt<PaymentMyFatorahCubit>().resetStates();
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appBarPayment(state, context),
            body: Builder(
              builder: (context) {
                switch (state.paymentSendState) {
                  case PaymentState.init:
                    return const PaymentInitWidget();
                  case PaymentState.methodsPaymentLoading:
                    return const PaymentMethodLoadingWidget();
                  case PaymentState.methodsPaymentSuccess:
                    return PaymentMethodsList(paymentMyFatorahModel);
                  case PaymentState.requestPaymentLoading:
                    return const PaymentRequestPaymentLoadingWidget();
                  case PaymentState.requestPaymentSuccess:
                    return const PaymentRequestPaymentSuccessWidget();
                  case PaymentState.statusPaymentLoading:
                    return const PaymentStatusLoadingWidget();
                  case PaymentState.statusPaymentSuccess:
                    return PaymentStatusSuccessWidget(
                        state: state,
                        paymentMyFatorahModel: paymentMyFatorahModel);
                  case PaymentState.executePaymentLoading:
                    return const PaymentExecuteLoadingWidget();
                  case PaymentState.executePaymentSuccess:
                    return PaymentExecuteSucsessAndUploadOrderWidget(
                        state: state,
                        paymentMyFatorahModel: paymentMyFatorahModel);
                  case PaymentState.paymentErorr:
                    return CustomErorrPageWidget(
                      errorMessage: state.erorrMessage,
                      onTap: () {
                        getIt<PaymentMyFatorahCubit>().initiatePayment(
                            num.parse(paymentMyFatorahModel.price));
                      },
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
