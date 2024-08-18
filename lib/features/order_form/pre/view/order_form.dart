import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/custom_auth_title.dart';
import '../../../../core/get_it/service_locator.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../view_model/cubit/add_order_cubit.dart';
import 'methods/add_order_listeners.dart';
import 'methods/fill_information_fileds.dart';
import 'widgets/add_order_attached_image_and_voice_and_flles_widget.dart';
import 'widgets/add_order_upload_button_widget.dart';
import 'widgets/audio/add_order_send_voice_widget.dart';
import 'widgets/files/add_order_send_file_widget.dart';
import 'widgets/image/add_order_send_picture_widget.dart';
import 'widgets/presonal_filed_widget.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key, this.typeOrder, this.price, this.value});
  final String? typeOrder;
  final String? price;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AddOrderCubit>()),
          BlocProvider.value(value: getIt<ProfileCubit>()),
        ],
        child: BlocConsumer<AddOrderCubit, AddOrderState>(
          listener: (context, state) {
            addorderListeners(context, state);
          },
          builder: (context, state) {
            final addOrderCubit = context.read<AddOrderCubit>();
            final profileCubit = context.read<ProfileCubit>();
            fillInformationFileds(profileCubit, addOrderCubit);
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: addOrderCubit.formKey,
                child: ListView(
                  children: [
                    CustomTextTitleAuth(title: 'how_can_help'.tr(context)),
                    const SizedBox(height: 20),
                    PersonalFiledWidget(addOrderCubit: addOrderCubit),
                    GlobalTextfield(
                        mycontroller: addOrderCubit.detailsController,
                        maxline: 5,
                        hinttext: "submit-consultation".tr(context)),
                    AddOrderSendFileWidget(
                        addOrderCubit: addOrderCubit, state: state),
                    const SizedBox(height: 15),
                    AddOrderSendVoiceWidget(state: state),
                    const SizedBox(height: 15),
                    AddOrderSendPictureWidget(state: state),
                    AddOrderAttachedImageAndVoiceAndFilesWidgets(
                        addOrderCubit: addOrderCubit, state: state),
                    const SizedBox(height: 15),
                    if (addOrderCubit.paymetnResponse != null)
                      CustomBotton(
                          backgroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          textColor: Theme.of(context).colorScheme.surface,
                          text: 'ارسال الطلب',
                          onPressed: () {
                            addOrderCubit.fetchAddOrder(typeOrder!);
                          }),
                    if (addOrderCubit.paymetnResponse == null)
                      AddOrderUploadButtonWidget(
                        addOrderCubit: addOrderCubit,
                        orderType: typeOrder ?? "",
                        price: price ?? "",
                      )
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
