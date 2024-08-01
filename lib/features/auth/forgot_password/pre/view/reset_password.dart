import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view_model/cubit/forgot_password_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_snackbar_widget.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, 'new_password'.tr(context)),
        body: BlocProvider.value(
          value: ForgotPasswordCubit(getIt()),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.forgotPasswordResetState == AuthRequestState.loading) {
                EasyLoading.show(
                    status: 'loading...'.tr(context),
                    maskType: EasyLoadingMaskType.black);
              } else if (state.forgotPasswordResetState ==
                  AuthRequestState.sucess) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(customSnackBarWidget(
                      "reset_password_success".tr(context), Colors.grey[800]!));
                GoRouter.of(context).pushReplacement(AppRouter.kLogin);
              } else if (state.forgotPasswordResetState ==
                  AuthRequestState.erorr) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(customSnackBarWidget(
                      erorrMessage(state.forgotPasswordResetMessage, context),
                      Colors.red));
              }
            },
            builder: (context, state) {
              final forgotCubit = context.read<ForgotPasswordCubit>();
              return Form(
                key: forgotCubit.formKey,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextTitleAuth(
                        title: "write_new_password".tr(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomAuthTextFormFeild(
                        hinttext: 'write_new_password'.tr(context),
                        label: 'password'.tr(context),
                        iconData: Icons.lock,
                        mycontroller: forgotCubit.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "write_new_password".tr(context);
                          } else if (value !=
                              forgotCubit.rePasswordController.text) {
                            return "password and repassword is not equal";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomAuthTextFormFeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "write_new_password".tr(context);
                          } else if (value !=
                              forgotCubit.passwordController.text) {
                            return "password and repassword is not equal";
                          }
                          return null;
                        },
                        hinttext: 're_write_pass'.tr(context),
                        label: 're_pass'.tr(context),
                        iconData: Icons.lock,
                        mycontroller: forgotCubit.rePasswordController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomBotton(
                        backgroundColor: AppColors.primeryColor,
                        textColor: AppColors.grey,
                        text: 'continue_btn'.tr(context),
                        onPressed: () {
                          forgotCubit.fetchRestPassword(
                              forgotCubit.passwordController.text);
                          //  GoRouter.of(context).push(AppRouter.kHomeView);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
