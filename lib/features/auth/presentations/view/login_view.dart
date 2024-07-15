// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:law_app/controller/auth/login_controller.dart';
// import 'package:law_app/core/constants/app_colors.dart';
// import 'package:law_app/core/widget/app_bar.dart';
// import 'package:law_app/view/widgets/auth_widget/custom_auth_welcome_text.dart';
// import '../../../core/constants/app_router.dart';
// import '../../../core/widget/custom_button.dart';
// import '../../widgets/auth_widget/custom_auth_title.dart';
// import '../../widgets/auth_widget/custom_textfield.dart';
// import '../../widgets/auth_widget/custom_text_signup_login.dart';
// import '../../widgets/auth_widget/logo.dart';
//
// class LoginView extends StatelessWidget {
//   const LoginView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     LoginControllerImp controller = Get.put(LoginControllerImp());
//     return Scaffold(
//         appBar: myAppBar(context, 'login'.tr,),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
//           child: ListView(
//             children: [
//                const AuthLogo(),
//               const SizedBox(height: 15,),
//               CustomTextTitleAuth(
//                 title: "welcome_back".tr,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextWelcomeAuth(
//                 welcometextbody: "welcome_text".tr,
//               ),
//               const SizedBox(
//                 height: 35,
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
//               CustomTextSignUpOrLogIn(
//                 texttwo: "4get".tr,
//                 onTap: () {
//                   controller.goToForgetPassword();
//                 },
//                 textone: '',
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomBotton(
//                 backgroundColor: AppColors.primeryColor,
//                 textColor: AppColors.grey,
//                 text: 'login'.tr,
//                 onPressed: () {
//                   Get.toNamed(AppRoutes.navbar);
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextSignUpOrLogIn(
//                   textone: "no_account".tr,
//                   texttwo: "sign_up_now".tr,
//                   onTap: () {
//                     controller.goToSignUp();
//                   }),
//             ],
//           ),
//         ));
//   }
// }
