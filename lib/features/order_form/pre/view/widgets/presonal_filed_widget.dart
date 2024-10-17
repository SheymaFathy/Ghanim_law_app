import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/auto_direction.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/profile.dart';
import '../../../../../core/widget/global_textfield.dart';
import '../../../../auth/widget/custom_textfield.dart';
import '../../view_model/cubit/add_order_cubit.dart';

class PersonalFiledWidget extends StatelessWidget {
  const PersonalFiledWidget({
    super.key,
    required this.addOrderCubit,
  });

  final AddOrderCubit addOrderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextfield(
          mycontroller: addOrderCubit.nameController,
          textAlign: isArabic(addOrderCubit.nameController.text)
              ? TextAlign.right
              : TextAlign.left,
          hinttext: 'name'.tr(context),
          iconData: Icons.person,
          readOnly: addOrderCubit.paymentResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "enter_name".tr(context);
            } else {
              return null;
            }
          },
        ),
        GlobalTextfield(
          mycontroller: addOrderCubit.emailController,
          hinttext: 'email'.tr(context),
          iconData: Icons.email,
          textAlign: isArabic(addOrderCubit.nameController.text)
              ? TextAlign.right
              : TextAlign.left,
          textDirection: isArabic(addOrderCubit.nameController.text)
              ? TextDirection.rtl
              : TextDirection.ltr,
          readOnly: addOrderCubit.paymentResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "enter_email".tr(context);
            } else {
              return null;
            }
          },
        ),
        BlocBuilder<AddOrderCubit, AddOrderState>(
          bloc: getIt<AddOrderCubit>(),
          builder: (context, state) {
            return InternationalPhoneNumberInput(
              locale: UserData.lang,
              searchBoxDecoration: InputDecoration(
                  label: Text(
                      "search by country name or digital code".tr(context))),
              onInputChanged: (PhoneNumber number) {
                addOrderCubit.togglePhoneNumber(number);
              },
              onInputValidated: (bool value) {},
              inputDecoration: InputDecoration(
                  hintText: "enter_phone".tr(context),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                  label: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "phone".tr(context),
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface),
                      )),
                  border: outlineInputBorder(context),
                  enabledBorder: outlineInputBorder(context),
                  focusedBorder: outlineInputBorder(context)),
              selectorConfig: const SelectorConfig(
                useEmoji: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
              ),
              countrySelectorScrollControlled: true,
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value!.length < 9) {
                  return "phone number is Short".tr(context);
                }
                if (value.isEmpty) {
                  return "Please Enter your phone number".tr(context);
                } else {
                  return null;
                }
              },
              selectorTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
              initialValue:
                  addOrderCubit.state.phoneNumber ?? addOrderCubit.phoneNumber,
              textFieldController: addOrderCubit.phoneController,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');

                addOrderCubit.phoneController.text =
                    number.phoneNumber.toString();
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
