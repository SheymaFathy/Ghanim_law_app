import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../view_model/cubit/add_order_cubit.dart';
import '../custom_attached_row.dart';
import 'attach_picture_widget.dart';

class AddOrderSendPictureWidget extends StatelessWidget {
  const AddOrderSendPictureWidget({super.key, required this.state});
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAttachedFile(
          text: 'send_pic'.tr(context),
          iconData: const Icon(Icons.photo_camera_back),
          ontab: state.isRecording
              ? null
              : () {
                  attachPictureWidget(context);
                },
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
