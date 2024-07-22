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
import 'widgets/audio/show_records_pickerd_item.dart';
import 'widgets/files/show_files_pickerd_item.dart';
import 'widgets/image/attach_picture_widget.dart';
import 'widgets/image/show_images_pikerd_item.dart';

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
                  CustomTextTitleAuth(title: 'how_can_hel؟'.tr(context)),
                  const SizedBox(height: 20),
                  GlobalTextfield(
                      maxline: 10, hinttext: "submit-consultation".tr(context)),
                  CustomAttachedFile(
                      text: 'send_file'.tr(context),
                      iconData: const Icon(Icons.file_present_sharp),
                      onPressedIcon:
                          state.isRecording ? null : addOrderCubit.attachFile),
                  const SizedBox(height: 15),
                  CustomAttachedFile(
                      text: 'Send_voice'.tr(context),
                      iconData: Icon(
                          color: state.isRecording ? Colors.red : Colors.blue,
                          state.isRecording ? Icons.mic_off : Icons.mic),
                      ontab: null,
                      onPressedIcon: state.isRecording
                          ? context.read<AddOrderCubit>().stopRecording
                          : context.read<AddOrderCubit>().startRecording),
                  const SizedBox(height: 15),
                  CustomAttachedFile(
                      text: 'send_pic'.tr(context),
                      iconData: const Icon(Icons.photo_camera_back),
                      onPressedIcon: state.isRecording
                          ? null
                          : () {
                              attachPictureWidget(context);
                            },
                      ontab: null),
                  if (state.imageFiles != null && state.imageFiles!.isNotEmpty)
                    ...state.imageFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      XFile image = entry.value;
                      return ShowImagesPickerdItem(image: image, index: index);
                    }),
                  if (addOrderCubit.recordsList != null &&
                      addOrderCubit.recordsList!.isNotEmpty)
                    ShowRecordsPickerdItem(
                        addOrderCubit: addOrderCubit, state: state),
                  if (state.pickedFiles != null)
                    ...state.pickedFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      PlatformFile file = entry.value;
                      return ShowFilesPickerdItem(file: file, index: index);
                    }),
                  const SizedBox(height: 15),
                  CustomBotton(
                      backgroundColor: AppColors.primeryColor,
                      textColor: AppColors.backgroundColor,
                      text: 'confirm'.tr(context),
                      onPressed: () {}),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
