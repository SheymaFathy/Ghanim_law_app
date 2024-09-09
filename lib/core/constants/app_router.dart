import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:ghanim_law_app/core/required_login_screen.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/forget_password_screen.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/otp_code.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/reset_password.dart';
import 'package:ghanim_law_app/features/auth/login/pre/view/login_screen.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view/sign_up_screen.dart';
import 'package:ghanim_law_app/features/feedback/pre/view/feed_back_screen.dart';
import 'package:ghanim_law_app/features/payment/pre/view/payment_secreen.dart';
import 'package:ghanim_law_app/features/order_details/pre/view/my_order_details.dart';
import 'package:ghanim_law_app/features/order_form/pre/view/order_form.dart';
import 'package:ghanim_law_app/features/privacy_policy/pre/view/privacy_policy_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/settings/pre/view/settings_page.dart';
import 'package:ghanim_law_app/features/splash/pre/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/about_us/pre/view/about_us_screen.dart';
import '../../features/auth/forgot_password/pre/view/success_reset_pass.dart';

import '../../features/main_pages/pre/pages/profile/pre/view/update_profile.dart';
import '../../features/main_pages/pre/view/main_screen.dart';
import '../../features/payment/data/model/invoice_model.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kSettings = '/settings';
  static const kSplash = "/onboarding";
  static const kLanguages = "/languages";
  static const kLogin = "/login";
  static const kSignup = "/ksignup";
  static const kForgetpassword = "/forgetpassword";
  static const kVerfiyCode = "/verfiycode";
  static const kResetPassword = "/resetpassword";
  static const kSeccessresetpass = "/seccessresetpass";
  static const kSeccesssignup = "/seccesssignup";
  static const kUpdateProfile = "/updateprofile";
  static const kFeedback = "/feedback";
  static const kOrderForm = "/orderform";
  static const kAboutUs = '/aboutUs';
  static const kpolicy = '/policy';
  static const korderdetails = '/orderdetails';
  static const kMyFatoora = "/payment";

  static final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            if (UserData.lang != null) {
              return const MainScreen();
            } else {
              return const SplashScreen();
            }
          }),
      GoRoute(
        path: kSettings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const MainScreen(),
      ),
      // auth pages
      GoRoute(
          path: kLogin,
          builder: (context, state) {
            if (state.extra != null) {
              Map<String, String>? args = state.extra as Map<String, String>?;
              return LoginScreen(
                email: args!['email'],
                password: args['password'],
              );
            } else {
              return const LoginScreen();
            }
          }),
      GoRoute(
        path: kSignup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: kForgetpassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: kResetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: kVerfiyCode,
        builder: (context, state) => const OtpCodeScreen(),
      ),
      GoRoute(
        path: kSeccessresetpass,
        builder: (context, state) => const SuccessResetPass(),
      ),
      GoRoute(
          path: kAboutUs, builder: (context, state) => const AboutUsScreen()),
      GoRoute(
          path: kUpdateProfile,
          builder: (context, state) => const UpdateProfile()),
      GoRoute(
          path: kFeedback, builder: (context, state) => const FeedBackScreen()),
      GoRoute(
          path: kOrderForm,
          builder: (context, state) {
            Map<String, String>? args = state.extra as Map<String, String>?;

            return Builder(builder: (context) {
              return checkUserMethod()
                  ? OrderForm(
                      typeOrder: args!['type']!,
                      price: args['price']!,
                    )
                  : const RequiredLoginScreen(isAppBar: true);
            });
          }),
      GoRoute(
          path: kpolicy,
          builder: (context, state) => const PrivacyPolicyPage()),
      GoRoute(
          path: korderdetails,
          builder: (context, state) {
            Map<String, int?>? args = state.extra as Map<String, int?>?;
            return MyOrderDetails(
              id: args!["id"]!,
            );
          }),

      GoRoute(
        path: kMyFatoora,
        builder: (context, state) {
          PaymentMyFatorahModel paymentMyFatorahModel =
              state.extra as PaymentMyFatorahModel;

          return PaymentMyFatorahScreen(
              paymentMyFatorahModel: paymentMyFatorahModel);
        },
      ),
    ],
  );
}
