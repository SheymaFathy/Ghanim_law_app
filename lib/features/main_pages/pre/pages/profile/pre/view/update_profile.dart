import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import '../../../../../../../core/widget/app_bar.dart';
import '../../../../../../auth/widget/custom_auth_title.dart';


class UpdateProfile extends StatelessWidget {
   const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: myAppBar(context, 'edit_profile'.tr(context)),
        body:  Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children:  [
              const CustomTextTitleAuth(title: 'تعديل الملف الشخصي'),
              const SizedBox(height: 20,),
              GlobalTextfield(hinttext: "enter_name".tr(context), label: "name".tr(context), iconData: Icons.person,),
              const SizedBox(height: 20,),
              GlobalTextfield(hinttext: "enter_phone".tr(context), label: "phone".tr(context), iconData: Icons.person,),
              const SizedBox(height: 20,),
              GlobalTextfield(hinttext: "enter_email".tr(context), label: "email".tr(context), iconData: Icons.person,),
              const SizedBox(height: 30,),
              CustomBotton(backgroundColor: AppColors.primeryColor, textColor: AppColors.backgroundColor, text: "confirm".tr(context), onPressed: (){})

            ],
          ),
        ));
  }
}
