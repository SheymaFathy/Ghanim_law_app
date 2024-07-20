import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/custom_auth_title.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view/widgets/custom_attached_row.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  void _attachFile(BuildContext context) {
  }

  void _recordVoice(BuildContext context) {

  }

  void _attachPicture(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const CustomTextTitleAuth(
              title: 'اخبرنا كيف نساعدك؟',
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              maxline: 8,
              hinttext: "submit-consultation".tr(context),
            ),
            CustomAttachedFile(
              text: 'send_file'.tr(context),
              iconData: Icons.file_present_sharp,
              ontab: () => _attachFile(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'Send_voice'.tr(context),
              iconData: Icons.mic,
              ontab: () => _recordVoice(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'send_pic'.tr(context),
              iconData: Icons.photo_camera_back,
              ontab: () => _attachPicture(context),
            ),
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
      ),
    );
  }
}
