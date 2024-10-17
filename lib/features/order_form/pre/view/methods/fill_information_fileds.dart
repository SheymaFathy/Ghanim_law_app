import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../../view_model/cubit/add_order_cubit.dart';

void fillInformationFileds(
    ProfileState profileState, AddOrderCubit addOrderCubit, context) {
  if (profileState.profileModel != null) {
    addOrderCubit.emailController.text =
        profileState.profileModel!.data!.email!;

    addOrderCubit.nameController.text = profileState.profileModel!.data!.name!;
    addOrderCubit.phoneController.text =
        profileState.profileModel!.data!.phone!;
    // addOrderCubit.phoneNumber = PhoneNumber(isoCode: "QA");
    PhoneNumber.getRegionInfoFromPhoneNumber(
            profileState.profileModel!.data!.phone!)
        .then((onValue) {
      addOrderCubit.togglePhoneNumber(onValue);
    }).catchError((onError) {
      print("""object""");
      onError as PlatformException;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This PhoneNumber is not valid".tr(context)),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}
