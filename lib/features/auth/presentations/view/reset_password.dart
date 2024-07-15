// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:law_app/controller/auth/reset_password_controller.dart';
// import 'package:law_app/core/constants/app_colors.dart';
// import 'package:law_app/core/widget/app_bar.dart';
// import '../../../core/constants/app_router.dart';
// import '../../../core/widget/custom_button.dart';
// import '../../widgets/auth_widget/custom_auth_title.dart';
// import '../../widgets/auth_widget/custom_textfield.dart';
//
// class ResetPassword extends StatelessWidget {
//   const ResetPassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     ResetPasswordControllerImp controller = Get.put(ResetPasswordControllerImp());
//     return Scaffold(
//         appBar: myAppBar(context, 'new_password'.tr),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//           child: ListView(
//             children: [
//               const SizedBox(height: 20,),
//               CustomTextTitleAuth(
//                 title: "write_new_password".tr,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'write_new_password'.tr,
//                 label: 'password'.tr,
//                 iconData: Icons.lock,
//                 mycontroller: controller.password,
//               ),
//               const SizedBox(height: 10,),
//               CustomAuthTextFormFeild(
//                 hinttext: 're_write_pass'.tr,
//                 label: 're_pass'.tr,
//                 iconData: Icons.lock,
//                 mycontroller: controller.repassword,
//               ),
//               const SizedBox(height: 10,),
//               CustomBotton(
//                 backgroundColor: AppColors.primeryColor,
//                 textColor: AppColors.grey,
//                 text: 'continue_btn'.tr,
//                 onPressed: (){
//                   Get.toNamed(AppRoutes.navbar);
//                 },
//               ),
//             ],
//           ),
//         ));
//   }
// }
