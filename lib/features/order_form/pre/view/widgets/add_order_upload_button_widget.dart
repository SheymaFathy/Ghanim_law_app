import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../core/widget/custom_button.dart';
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
            text: '${"request".tr(context)} ${orderType.tr(context)}',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('warning'.tr(context)),
                    content: Text(
                        'You cannot undo sending the service request after completing the payment process.'
                            .tr(context)),
                    actions: <Widget>[
                      TextButton(
                        child: Text('cancel'.tr(context)),
                        onPressed: () {
                          Navigator.of(context).pop(); // إغلاق النافذة
                        },
                      ),
                      TextButton(
                        child: Text('confirm'.tr(context)),
                        onPressed: () {
                          addOrderCubit.validatorAddOrder(
                              context, orderType, price);
                        },
                      ),
                    ],
                  );
                },
              );
            });
  }
}
