import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/order_form/pre/view/widgets/custom_attached_row.dart';

import '../../../view_model/cubit/add_order_cubit.dart';

class AddOrderSendFileWidget extends StatelessWidget {
  const AddOrderSendFileWidget(
      {super.key, required this.addOrderCubit, required this.state});

  final AddOrderCubit addOrderCubit;
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return CustomAttachedFile(
        text: 'send_file'.tr(context),
        iconData: const Icon(Icons.file_present_sharp),
        ontab: state.isRecording ? null : addOrderCubit.attachFile);
  }
}
