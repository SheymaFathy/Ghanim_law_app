import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/forget_password_screen.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/otp_code.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view/reset_password.dart';
import 'package:ghanim_law_app/features/auth/login/pre/view/login_screen.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view/sign_up_screen.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/settings/pre/view/settings_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/forgot_password/pre/view/success_reset_pass.dart';
import '../../features/auth/sign_up/pre/view/sign_up_view_body.dart';
import '../../features/main_pages/pre/view/main_screen.dart';
import '../../features/splash/pre/view/splash_screen.dart';

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
  static const kOrderform = "/orderform";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kLogin,
        builder: (context, state) => const SplashScreen(),
      ),
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
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
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
    ],
  );
}
