import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';
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
    return BlocProvider(
      create: (context) => PaymentMyFatorahCubit()
        ..initiApi(num.parse(paymentMyFatorahModel.price)),
      child: BlocConsumer<PaymentMyFatorahCubit, PaymentMyFatorahState>(
        listener: (context, state) async {
          if (state.paymentSendState == PaymentState.executePaymentSuccess) {
            await Future.delayed(const Duration(seconds: 5)).then((onValue) {
              getIt<AddOrderCubit>().paymetnResponse =
                  state.executePaymentResponse;
            });
          } else if (state.paymentSendState == PaymentState.paymentErorr) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  customSnackBarWidget(state.erorrMessage, Colors.red));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: state.paymentSendState ==
                            PaymentState.executePaymentLoading ||
                        state.paymentSendState ==
                            PaymentState.executePaymentSuccess
                    ? false
                    : true,
                title: state.paymentSendState ==
                        PaymentState.methodsPaymentLoading
                    ? const Text('Select payment method')
                    : state.paymentSendState ==
                            PaymentState.methodsPaymentSuccess
                        ? const Text('Select payment method')
                        : state.paymentSendState ==
                                PaymentState.statusPaymentLoading
                            ? const Text('Payment Details')
                            : state.paymentSendState ==
                                    PaymentState.statusPaymentSuccess
                                ? const Text('Payment Details')
                                : state.paymentSendState ==
                                        PaymentState.executePaymentLoading
                                    ? const Text("Payment is being completed")
                                    : state.paymentSendState ==
                                            PaymentState.executePaymentSuccess
                                        ? const Text(
                                            "The payment was completed successfully")
                                        : const Text(""),
                centerTitle: true),
            body: Builder(
              builder: (context) {
                switch (state.paymentSendState) {
                  case PaymentState.init:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text("Payment methods are being set up. Please wait."
                            .tr(context))
                      ],
                    );
                  case PaymentState.methodsPaymentLoading:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text(
                            "Loading payment methods. Please wait.".tr(context))
                      ],
                    );
                  case PaymentState.methodsPaymentSuccess:
                    return PaymentMethodsList(paymentMyFatorahModel);
                  case PaymentState.requestPaymentLoading:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text("Processing your payment request.".tr(context))
                      ],
                    );
                  case PaymentState.requestPaymentSuccess:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text(
                            "Your payment request has been successfully processed. Displaying details now."
                                .tr(context))
                      ],
                    );
                  case PaymentState.statusPaymentLoading:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text("Initializing order status.".tr(context))
                      ],
                    );
                  case PaymentState.statusPaymentSuccess:
                    return Column(
                      children: [
                        Expanded(
                            child: PaymentDetailsView(
                                stateResponse: state.paymentStatusResponse!)),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: CustomBotton(
                              borderRadius: BorderRadius.circular(12),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                              textColor: Theme.of(context).colorScheme.surface,
                              text: "Checkout".tr(context),
                              onPressed: () {
                                context
                                    .read<PaymentMyFatorahCubit>()
                                    .executeRegularPayment(
                                        paymentMyFatorahModel, context);
                              }),
                        )
                      ],
                    );
                  case PaymentState.executePaymentLoading:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: CircularProgressIndicator()),
                        Text("Initializing payment page.".tr(context))
                      ],
                    );
                  case PaymentState.executePaymentSuccess:
                    return BlocProvider.value(
                      value: getIt<AddOrderCubit>()
                        ..fetchUploadOrder(paymentMyFatorahModel.serviceName),
                      child: BlocBuilder<AddOrderCubit, AddOrderState>(
                        builder: (context, addOrderState) {
                          switch (addOrderState.addOrderState) {
                            case AuthRequestState.normal:
                            case AuthRequestState.loading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case AuthRequestState.sucess:
                              return Column(
                                children: [
                                  Expanded(
                                      child: PaymentDetailsView(
                                          stateResponse:
                                              state.executePaymentResponse!)),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: CustomBotton(
                                        borderRadius: BorderRadius.circular(12),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        text: "تمت عملية الدفع بنجاح",
                                        onPressed: () {}),
                                  )
                                ],
                              );
                            case AuthRequestState.erorr:
                              return Text(addOrderState.erorrMessage);
                          }
                        },
                      ),
                    );
                  case PaymentState.paymentErorr:
                    return CustomErorrPageWidget(
                      errorMessage: state.erorrMessage,
                      onTap: () {},
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
