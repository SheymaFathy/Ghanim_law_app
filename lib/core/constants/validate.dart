// import 'package:get/get.dart';
//
// class ValidatorDef {
//   static String? validatorEmail(val) {
//     if (val == null || val.isEmpty) {
//       return "enter_email".tr;
//     }
//     if (!val.contains("@") || !val.contains(".")) {
//       return "valid_email".tr;
//     }
//     return null;
//   }
//
//   static String? validatorPassword(val) {
//     if (val == null || val.isEmpty) {
//       return "enter_pass".tr;
//     }
//     return null;
//   }
//
//   static String? validatorName(val) {
//     if (val == null || val.isEmpty) {
//       return "enter_name".tr;
//     }
//     return null;
//   }
//
//   static String? validatorPhone(val) {
//     if (val == null || val.isEmpty) {
//       return "enter_phone".tr;
//     }
//     if ((val.toString()).length < 11) {
//       return "valid_phone".tr;
//     }
//     return null;
//   }
//
//   static String? validatorConsultation(val) {
//     if (val == null || val.isEmpty || val.toString().length < 120) {
//       return "enter_consultation".tr;
//     }
//     return null;
//   }
// }
