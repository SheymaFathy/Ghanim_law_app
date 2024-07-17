import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view_model/cubit/forgot_password_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/widget/snake_bar_erorr.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';

class OtpCodeScreen extends StatelessWidget {
  const OtpCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, '4getpass'.tr(context)),
        body: BlocProvider.value(
          value: ForgotPasswordCubit(getIt()),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.forgotPasswordGetCodeState ==
                  AuthRequestState.loading) {
                EasyLoading.show(
                    status: 'loading...'.tr(context),
                    maskType: EasyLoadingMaskType.black);
              } else if (state.forgotPasswordGetCodeState ==
                  AuthRequestState.sucess) {
                EasyLoading.dismiss();
                GoRouter.of(context).push(AppRouter.kResetPassword);
              } else if (state.forgotPasswordGetCodeState ==
                  AuthRequestState.erorr) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBarErorr(
                      state.forgotPasswordGetCodeMessage,
                      "4getpass".tr(context)));
              }
            },
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: ListView(
                  children: [
                    CustomTextTitleAuth(
                      title: "otp_code".tr(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextWelcomeAuth(
                      welcometextbody: "otp_code_text".tr(context),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    OtpTextField(
                      fieldWidth: 50,
                      borderRadius: BorderRadius.circular(15),
                      numberOfFields: 5,
                      borderColor: AppColors.primeryColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},

                      onSubmit: (String verificationCode) {
                        context
                            .read<ForgotPasswordCubit>()
                            .getResetPassowdCode(verificationCode);
                      }, // end onSubmit
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
