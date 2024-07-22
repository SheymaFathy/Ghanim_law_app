import 'dart:io';
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
                    iconData: Icons.file_present_sharp,
                    ontab: () => addOrderCubit.attachFile(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAttachedFile(
                    text: 'Send_voice'.tr(context),
                    iconData: Icons.mic,
                    ontab: () {
                      attachVoiceWidget(context);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAttachedFile(
                    text: 'send_pic'.tr(context),
                    iconData: Icons.photo_camera_back,
                    ontab: () => attachPictureWidget(context),
                  ),
                  if (state.imageFiles != null && state.imageFiles!.isNotEmpty)
                    ...state.imageFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      XFile image = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.file(
                                File(image.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(image.name),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => showDeletePhotoDialog(
                                index,
                                "image",
                                context,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  if (addOrderCubit.recordsList != null &&
                      addOrderCubit.recordsList!.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: addOrderCubit.recordsList!.length,
                        itemBuilder: (context, index) {
                          print(state.records!);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child:
                                      Text(addOrderCubit.recordsList![index]),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDeletePhotoDialog(
                                        index,
                                        "image",
                                        context,
                                      );
                                    }),
                              ],
                            ),
                          );
                        }),
                  if (state.pickedFiles != null &&
                      state.pickedFiles!.isNotEmpty)
                    ...state.pickedFiles!.asMap().entries.map((entry) {
                      int index = entry.key;
                      PlatformFile file = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.insert_drive_file,
                                color: Colors.grey),
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
