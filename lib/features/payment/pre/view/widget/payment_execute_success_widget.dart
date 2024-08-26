import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/features/payment/pre/view/widget/payment_details_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../core/constants/app_router.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../order_form/pre/view_model/cubit/add_order_cubit.dart';
import '../../../data/model/invoice_model.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';

class PaymentExecuteSucsessAndUploadOrderWidget extends StatelessWidget {
  const PaymentExecuteSucsessAndUploadOrderWidget(
      {super.key, required this.paymentMyFatorahModel, required this.state});

  final PaymentMyFatorahModel paymentMyFatorahModel;
  final PaymentMyFatorahState state;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) async {
        if (state.addOrderState == AuthRequestState.sucess) {
          await getIt<PaymentMyFatorahCubit>().resetStates();
        }
      },
      bloc: getIt<AddOrderCubit>()
        ..fetchUploadOrder(paymentMyFatorahModel.serviceName),
      builder: (context, addOrderState) {
        switch (addOrderState.addOrderState) {
          case AuthRequestState.normal:
          case AuthRequestState.loading:
            return Container();

          case AuthRequestState.sucess:
            return PopScope(
              canPop: false,
              child: Column(
                children: [
                  Expanded(
                      child: PaymentDetailsView(
                          stateResponse: state.executePaymentResponse!)),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: CustomBotton(
                        borderRadius: BorderRadius.circular(12),
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        textColor: Theme.of(context).colorScheme.surface,
                        text: "Go to the home page".tr(context),
                        onPressed: () {
                          GoRouter.of(context).go(AppRouter.kHomeView);
                        }),
                  )
                ],
              ),
            );
          case AuthRequestState.erorr:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(addOrderState.erorrMessage)),
              ],
            );
        }
      },
    );
  }
}
