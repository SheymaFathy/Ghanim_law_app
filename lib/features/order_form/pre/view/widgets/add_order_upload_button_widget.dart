import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../view_model/cubit/add_order_cubit.dart';

class AddOrderUploadButtonWidget extends StatelessWidget {
  const AddOrderUploadButtonWidget(
      {super.key,
      required this.state,
      required this.addOrderCubit,
      required this.orderType});
  final AddOrderState state;
  final AddOrderCubit addOrderCubit;
  final String orderType;
  @override
  Widget build(BuildContext context) {
    return state.isRecording
        ? Column(
            children: [
              const LinearProgressIndicator(color: Colors.black),
              Text("Recording audio...".tr(context)),
            ],
          )
        : CustomBotton(
            backgroundColor: AppColors.primeryColor,
            textColor: AppColors.backgroundColor,
            text: 'confirm'.tr(context),
            onPressed: () {
              addOrderCubit.fetchAddOrder(orderType);
            });
  }
}
