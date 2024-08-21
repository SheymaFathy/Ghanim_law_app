import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/order_form/pre/view/widgets/custom_attached_row.dart';

import '../../../view_model/cubit/add_order_cubit.dart';

class AddOrderSendVoiceWidget extends StatelessWidget {
  const AddOrderSendVoiceWidget({super.key, required this.state});
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return CustomAttachedFile(
        text: 'Send_voice'.tr(context),
        iconData: Icon(
            color: state.isRecording ? Colors.red : Colors.blue,
            state.isRecording ? Icons.stop : Icons.mic),
        ontab: state.isRecording
            ? context.read<AddOrderCubit>().stopRecording
            : context.read<AddOrderCubit>().startRecording);
  }
}
