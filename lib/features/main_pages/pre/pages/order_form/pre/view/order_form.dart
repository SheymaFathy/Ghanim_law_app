import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/custom_auth_title.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view/widgets/custom_attached_row.dart';

import '../../../../../../../core/get_it/service_locator.dart';
import '../view_model/cubit/add_order_cubit.dart';
import 'widgets/files/show_file_options_dialog.dart';
import 'widgets/image/attach_picture_widget.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            final addOrderCubit = context.read<AddOrderCubit>();
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  CustomTextTitleAuth(
                    title: 'how_can_hel؟'.tr(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GlobalTextfield(
                    maxline: 10,
                    hinttext: "submit-consultation".tr(context),
                  ),
                  CustomAttachedFile(
                    text: 'send_file'.tr(context),
                    iconData: Icon(Icons.file_present_sharp),
                    ontab: null,
                    onPressedIcon:
                        state.isRecording ? null : addOrderCubit.attachFile,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAttachedFile(
                    text: 'Send_voice'.tr(context),
                    iconData: Icon(
                        color: state.isRecording ? Colors.red : Colors.blue,
                        state.isRecording ? Icons.mic_off : Icons.mic),
                    ontab: null,
                    onPressedIcon: state.isRecording
                        ? context.read<AddOrderCubit>().stopRecording
                        : context.read<AddOrderCubit>().startRecording,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAttachedFile(
                    text: 'send_pic'.tr(context),
                    iconData: const Icon(Icons.photo_camera_back),
                    onPressedIcon: state.isRecording
                        ? null
                        : () {
                            attachPictureWidget(context);
                          },
                    ontab: null,
                  ),
                  if (state.imageFiles != null && state.imageFiles!.isNotEmpty)
                    ...state.imageFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      XFile image = entry.value;
                      return ShowImagesPickerItem(image: image, index: index);
                    }),
                  if (addOrderCubit.recordsList != null &&
                      addOrderCubit.recordsList!.isNotEmpty)
                    ShowRecordsPickerItem(addOrderCubit: addOrderCubit),
                  if (state.pickedFiles != null &&
                      state.pickedFiles!.isNotEmpty)
                    ...state.pickedFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      PlatformFile file = entry.value;
                      return ShowFIlesPickersItem(file: file, index: index);
                    }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomBotton(
                    backgroundColor: AppColors.primeryColor,
                    textColor: AppColors.backgroundColor,
                    text: 'confirm'.tr(context),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShowImagesPickerItem extends StatelessWidget {
  const ShowImagesPickerItem({
    super.key,
    required this.image,
    required this.index,
  });

  final XFile image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.file(File(image.path), fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(image.name),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => showDeletePhotoDialog(index, "image", context),
          ),
        ],
      ),
    );
  }
}

class ShowRecordsPickerItem extends StatelessWidget {
  const ShowRecordsPickerItem({
    super.key,
    required this.addOrderCubit,
  });

  final AddOrderCubit addOrderCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: addOrderCubit.state.records!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                Text("${"record_voice".tr(context)} ( ${(index).toString()} )"),
                const Spacer(),
                if (!addOrderCubit.state.isRecording)
                  IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                    ),
                    onPressed: () {
                      attachVoiceWidget(
                          context, addOrderCubit.state.records![index]);
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDeletePhotoDialog(index, "audio", context);
                  },
                ),
              ],
            ),
          );
        });
  }
}

class ShowFIlesPickersItem extends StatelessWidget {
  const ShowFIlesPickersItem({
    super.key,
    required this.file,
    required this.index,
  });

  final PlatformFile file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(file.name),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => showDeleteFileDialog(
              index,
              "file",
              context,
            ),
          ),
        ],
      ),
    );
  }
}
