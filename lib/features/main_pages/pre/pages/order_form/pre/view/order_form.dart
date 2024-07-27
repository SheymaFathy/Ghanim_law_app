import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';

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
import '../../../../../../../core/widget/custom_snackbar_widget.dart';
import '../../../my_orders/pre/view_model/cubit/my_order_cubit.dart';
import '../../../profile/pre/view_model/cubit/profile_cubit.dart';
import '../view_model/cubit/add_order_cubit.dart';
import 'widgets/audio/show_records_pickerd_item.dart';
import 'widgets/files/show_files_pickerd_item.dart';
import 'widgets/image/attach_picture_widget.dart';
import 'widgets/image/show_images_pikerd_item.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key, required this.typeOrder});
  final String typeOrder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<AddOrderCubit>(),
          ),
          BlocProvider.value(
            value: getIt<ProfileCubit>(),
          ),
        ],
        child: BlocConsumer<AddOrderCubit, AddOrderState>(
          listener: (context, state) {
            if (state.addOrderState == AuthRequestState.loading) {
              EasyLoading.show(
                  status: 'loading...'.tr(context),
                  maskType: EasyLoadingMaskType.black);
            } else if (state.addOrderState == AuthRequestState.erorr) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    customSnackBarWidget(state.erorrMessage, Colors.red));
            } else if (state.addOrderState == AuthRequestState.sucess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBarWidget(
                    "order_sccess".tr(context), Colors.grey[800]!));
              getIt<MyOrderCubit>().fetchOrdersData();
            }
          },
          builder: (context, state) {
            final addOrderCubit = context.read<AddOrderCubit>();
            final profileCubit = context.read<ProfileCubit>();
            if (profileCubit.state.profileModel != null) {
              addOrderCubit.emailController.text =
                  profileCubit.state.profileModel!.data!.email!;
              addOrderCubit.nameController.text =
                  profileCubit.state.profileModel!.data!.name!;
              addOrderCubit.phoneController.text =
                  profileCubit.state.profileModel!.data!.phone!;
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: addOrderCubit.formKey,
                child: ListView(
                  children: [
                    CustomTextTitleAuth(title: 'how_can_help'.tr(context)),
                    const SizedBox(height: 20),
                    GlobalTextfield(
                      mycontroller: addOrderCubit.nameController,
                      hinttext: 'name'.tr(context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    GlobalTextfield(
                      mycontroller: addOrderCubit.emailController,
                      hinttext: 'email'.tr(context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    GlobalTextfield(
                      mycontroller: addOrderCubit.phoneController,
                      hinttext: 'phone'.tr(context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    GlobalTextfield(
                        mycontroller: addOrderCubit.detailsController,
                        maxline: 5,
                        hinttext: "submit-consultation".tr(context)),
                    CustomAttachedFile(
                        text: 'send_file'.tr(context),
                        iconData: const Icon(Icons.file_present_sharp),
                        onPressedIcon: state.isRecording
                            ? null
                            : addOrderCubit.attachFile),
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
                    if (state.imageFiles != null &&
                        state.imageFiles!.isNotEmpty)
                      ...state.imageFiles!.asMap().entries.map((entry) {
                        int index = entry.key;
                        XFile image = entry.value;
                        return ShowImagesPickerdItem(
                            image: image, index: index);
                      }),
                    if (addOrderCubit.recordsList != null &&
                        addOrderCubit.recordsList != null)
                      ShowRecordsPickerdItem(
                          addOrderCubit: addOrderCubit, state: state),
                    if (state.pickedFiles != null)
                      ...state.pickedFiles!.asMap().entries.map((entry) {
                        int index = entry.key;
                        PlatformFile file = entry.value;
                        return ShowFilesPickerdItem(file: file, index: index);
                      }),
                    const SizedBox(height: 15),
                    state.isRecording
                        ? Column(
                            children: [
                              const LinearProgressIndicator(
                                  color: Colors.black),
                              Text("Recording audio...".tr(context)),
                            ],
                          )
                        : CustomBotton(
                            backgroundColor: AppColors.primeryColor,
                            textColor: AppColors.backgroundColor,
                            text: 'confirm'.tr(context),
                            onPressed: () {
                              addOrderCubit.fetchAddOrder(typeOrder);
                            }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
