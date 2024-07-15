// // import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:law_app/controller/auth/otp_controller.dart';
// import 'package:law_app/core/constants/app_colors.dart';
// import 'package:law_app/core/widget/app_bar.dart';
// import 'package:law_app/view/widgets/auth_widget/custom_auth_welcome_text.dart';
// import '../../widgets/auth_widget/custom_auth_title.dart';
//
// class OtpCode extends StatelessWidget {
//   const OtpCode({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     OtpControllerImp controller = Get.put(OtpControllerImp());
//     return Scaffold(
//         appBar: myAppBar(context, '4getpass'.tr),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//           child: ListView(
//             children: [
//               CustomTextTitleAuth(
//                 title: "otp_code".tr,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextWelcomeAuth(
//                 welcometextbody: "otp_code_text".tr,
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               OtpTextField(
//                 fieldWidth: 50,
//                 borderRadius: BorderRadius.circular(15),
//                 numberOfFields: 5,
//                 borderColor: AppColors.primeryColor,
//                 //set to true to show as box or false to show as dash
//                 showFieldAsBox: true,
//                 //runs when a code is typed in
//                 onCodeChanged: (String code) {
//                   //handle validation or checks here
//                 },
//                 //runs when every textfield is filled
//                 onSubmit: (String verificationCode){
//                   controller.goToResetPass();
//                 }, // end onSubmit
//               ),
//               const SizedBox(height: 30,),
//
//             ],
//           ),
//         ));
//   }
// }
