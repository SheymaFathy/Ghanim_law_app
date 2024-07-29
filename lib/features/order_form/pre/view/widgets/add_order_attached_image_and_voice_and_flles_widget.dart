import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';
import 'package:image_picker/image_picker.dart';

import 'audio/show_records_pickerd_item.dart';
import 'files/show_files_pickerd_item.dart';
import 'image/show_images_pikerd_item.dart';

class AddOrderAttachedImageAndVoiceAndFilesWidgets extends StatelessWidget {
  const AddOrderAttachedImageAndVoiceAndFilesWidgets(
      {super.key, required this.addOrderCubit, required this.state});

  final AddOrderCubit addOrderCubit;
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (state.imageFiles != null && state.imageFiles!.isNotEmpty)
          ...state.imageFiles!.asMap().entries.map((entry) {
            int index = entry.key;
            XFile image = entry.value;
            return ShowImagesPickerdItem(image: image, index: index);
          }),
        if (addOrderCubit.recordsList != null &&
            addOrderCubit.recordsList != null)
          ShowRecordsPickerdItem(addOrderCubit: addOrderCubit, state: state),
        if (state.pickedFiles != null)
          ...state.pickedFiles!.asMap().entries.map((entry) {
            int index = entry.key;
            PlatformFile file = entry.value;
            return ShowFilesPickerdItem(file: file, index: index);
          }),
      ],
    );
  }
}
