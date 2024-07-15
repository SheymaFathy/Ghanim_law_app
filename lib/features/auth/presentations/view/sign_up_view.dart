// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:law_app/core/constants/app_colors.dart';
// import 'package:law_app/core/widget/app_bar.dart';
// import 'package:law_app/view/widgets/auth_widget/custom_auth_welcome_text.dart';
// import 'package:law_app/view/widgets/auth_widget/custom_text_signup_login.dart';
// import '../../../controller/auth/sign_up_controller.dart';
// import '../../../core/constants/app_router.dart';
// import '../../../core/widget/custom_button.dart';
// import '../../widgets/auth_widget/custom_auth_title.dart';
// import '../../widgets/auth_widget/custom_textfield.dart';
//
// class SignUpView extends StatelessWidget {
//   const SignUpView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SignUpControllerImp controller = Get.put(SignUpControllerImp());
//     return Scaffold(
//         appBar: myAppBar(context, 'sign_up'.tr),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//           child: ListView(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextTitleAuth(
//                 title: "welcome".tr,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextWelcomeAuth(
//                 welcometextbody: "welcome_sign_up_text".tr,
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'enter_name'.tr,
//                 label: 'name'.tr,
//                 iconData: Icons.person,
//                 mycontroller: controller.name,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'enter_email'.tr,
//                 label: 'email'.tr,
//                 iconData: Icons.email_outlined,
//                 mycontroller: controller.email,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'enter_phone'.tr,
//                 label: 'phone'.tr,
//                 iconData: Icons.phone,
//                 mycontroller: controller.phone,
//               ),
//               CustomAuthTextFormFeild(
//                 hinttext: 'enter_pass'.tr,
//                 label: 'password'.tr,
//                 iconData: Icons.lock,
//                 mycontroller: controller.password,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomBotton(
//                 backgroundColor: AppColors.primeryColor,
//                 textColor: AppColors.grey,
//                 text: 'login'.tr,
//                 onPressed: () {
//                   controller.goToLogin();
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               CustomTextSignUpOrLogIn(
//                   textone: "account".tr,
//                   texttwo: "login_now".tr,
//                   onTap: () {
//                     Get.toNamed(AppRoutes.login);
//                   }),
//             ],
//           ),
//         ));
//   }
// }
