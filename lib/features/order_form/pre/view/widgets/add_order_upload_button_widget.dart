import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widget/custom_button.dart';
import '../../../../payment/data/model/invoice_model.dart';
import '../../view_model/cubit/add_order_cubit.dart';

class AddOrderUploadButtonWidget extends StatelessWidget {
  const AddOrderUploadButtonWidget(
      {super.key,
      required this.addOrderCubit,
      required this.orderType,
      required this.price});

  final AddOrderCubit addOrderCubit;
  final String orderType;
  final String price;
  @override
  Widget build(BuildContext context) {
    return addOrderCubit.state.isRecording
        ? Column(
            children: [
              LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.onSurface),
              Text("Recording audio...".tr(context)),
            ],
          )
        : CustomBotton(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            textColor: Theme.of(context).colorScheme.surface,
            text: 'confirm'.tr(context),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kMyFatoora,
                  extra: PaymentMyFatorahModel(
                      serviceName: orderType,
                      name: addOrderCubit.nameController.text,
                      email: addOrderCubit.emailController.text,
                      price: price));
              // addOrderCubit.fetchAddOrder(orderType);
            });
  }
}
