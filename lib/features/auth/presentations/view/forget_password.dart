// import 'package:flutter/material.dart';
//
//
// class ForgetPassword extends StatelessWidget {
//   const ForgetPassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // ForgetPasswordControllerImp controller = Get.put(ForgetPasswordControllerImp());
//     return Scaffold(
//         appBar: myAppBar(context, '4getpass'.tr),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//           child: ListView(
//             children: [
//               CustomTextTitleAuth(
//                 title: "checkphone".tr,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextWelcomeAuth(
//                 welcometextbody: "check_text".tr,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'enter_phone'.tr,
//                 label: 'phone'.tr,
//                 iconData: Icons.phone,
//                 mycontroller: controller.phone,
//               ),
//               const SizedBox(height: 10,),
//               CustomBotton(
//                 backgroundColor: AppColors.primeryColor,
//                 textColor: AppColors.grey,
//                 text: 'checkbtn'.tr,
//                 onPressed: (){
//                   controller.goToOtpCode();
//                 },
//               ),
//             ],
//           ),
//         ));
//   }
// }
