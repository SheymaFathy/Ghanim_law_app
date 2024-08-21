import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../core/widget/global_textfield.dart';
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
          hinttext: 'name'.tr(context),
          readOnly: addOrderCubit.paymetnResponse == null ? false : true,
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
          readOnly: addOrderCubit.paymetnResponse == null ? false : true,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter email";
            } else {
              return null;
            }
          },
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              addOrderCubit.countryCode = number.dialCode.toString();
              print(addOrderCubit.countryCode);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter phone number";
              } else {
                return null;
              }
            },
            inputDecoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintStyle: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            ),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              useBottomSheetSafeArea: true,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.always,
            selectorTextStyle: TextStyle(color: Colors.black),
            textFieldController: addOrderCubit.phoneController,
            formatInput: true,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(),
            onFieldSubmitted: (value) {},
            onSaved: (PhoneNumber number) {
              addOrderCubit.countryCode = number.dialCode.toString();
              print(addOrderCubit.countryCode);
            },
          ),
        ),
      ],
    );
  }
}
