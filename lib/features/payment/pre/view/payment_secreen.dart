import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widget/custom_erorr_page_widget.dart';
import '../../../../core/widget/custom_snackbar_widget.dart';
import '../../data/model/invoice_model.dart';
import 'widget/appbar_payment_widget.dart';
import 'widget/custom_loading_payment.dart';
import 'widget/payment_execute_loading_widget.dart';
import 'widget/payment_init_widget.dart';
import 'widget/payment_method_loading_widget.dart';
import 'widget/payment_methods_list.dart';
import 'widget/payment_status_loading_widget.dart';
import 'widget/payment_status_success_widget.dart';

class PaymentMyFatorahScreen extends StatelessWidget {
  const PaymentMyFatorahScreen({
    super.key,
    required this.paymentMyFatorahModel,
  });
  final PaymentMyFatorahModel paymentMyFatorahModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      bloc: getIt<AddOrderCubit>()..init(paymentMyFatorahModel),
      listener: (context, state) async {
        if (state.paymentSendState == PaymentState.executePaymentSuccess) {
          await Future.delayed(const Duration(seconds: 5)).then((onValue) {});
        } else if (state.paymentSendState == PaymentState.paymentErorr) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                customSnackBarWidget(state.erorrMessage, Colors.red));
          // getIt<AddOrderCubit>().resetStates();
          // GoRouter.of(context).pop();
          // GoRouter.of(context).pop();
        } else if (state.paymentSendState == PaymentState.sendOrderIdSuccess) {
          GoRouter.of(context).pop();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBarWidget(
                "The payment was completed successfully".tr(context),
                Colors.green));
          getIt<MyOrderCubit>().fetchOrdersData();
          // GoRouter.of(context).replace(AppRouter.korderdetails, extra: {
          //   "appbar": false,
          //   "id": int.parse(
          //       state.paymentResponseOrderId!.customerReference.toString())
          // });
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
                case PaymentState.statusPaymentLoading:
                  return const PaymentStatusLoadingWidget();
                case PaymentState.statusPaymentSuccess:
                  return PaymentStatusSuccessWidget(
                      state: state,
                      paymentMyFatorahModel: paymentMyFatorahModel);
                case PaymentState.executePaymentLoading:
                  return const PaymentExecuteLoadingWidget();
                case PaymentState.executePaymentSuccess:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case PaymentState.paymentErorr:
                  return CustomErorrPageWidget(
                    errorMessage: state.erorrMessage,
                    onTap: () {
                      getIt<AddOrderCubit>()
                          .initiatePayment(paymentMyFatorahModel);
                    },
                  );
                case PaymentState.sendOrderIdLoading:
                  return CustomLoadingPayment(
                    text: "Wait a few moments.".tr(context),
                  );
                case PaymentState.sendOrderIdSuccess:
                  return const Center(child: CircularProgressIndicator());

                case PaymentState.sendOrderIdError:
                  return CustomErorrPageWidget(
                    errorMessage: state.erorrMessage,
                    onTap: () {
                      getIt<AddOrderCubit>().fetchPainOrder(
                          paymentMyFatorahModel.orderID.toString(),
                          state.executePaymentResponse!.invoiceId!.toString());
                    },
                  );
              }
            },
          ),
        );
      },
    );
  }
}
