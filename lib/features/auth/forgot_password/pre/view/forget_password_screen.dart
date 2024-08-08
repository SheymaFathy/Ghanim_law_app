import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/pre/view_model/cubit/forgot_password_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../core/widget/app_bar.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../../core/widget/custom_snackbar_widget.dart';
import '../../../widget/custom_auth_title.dart';
import '../../../widget/custom_auth_welcome_text.dart';
import '../../../widget/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: myAppBar(context, '4getpass'.tr(context)),
        body: BlocProvider(
          create: (context) => ForgotPasswordCubit(getIt()),
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.forgotPasswordState == AuthRequestState.loading) {
                EasyLoading.show(
                    status: 'loading...'.tr(context),
                    maskType: EasyLoadingMaskType.black);
              } else if (state.forgotPasswordState == AuthRequestState.sucess) {
                EasyLoading.dismiss();
                GoRouter.of(context).push(AppRouter.kVerfiyCode);
              } else if (state.forgotPasswordState == AuthRequestState.erorr) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(customSnackBarWidget(
                      erorrMessage(state.forgotPasswordMessage, context),
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
                      CustomTextTitleAuth(
                        title: "checkphone".tr(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextWelcomeAuth(
                        welcometextbody: "check_text".tr(context),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomAuthTextFormFeild(
                        hinttext: 'enter_phone'.tr(context),
                        label: 'phone'.tr(context),
                        iconData: Icons.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter_phone".tr(context);
                          } else {
                            return null;
                          }
                        },
                        mycontroller: forgotCubit.phoneController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomBotton(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        textColor: Theme.of(context).colorScheme.surface,
                        text: 'checkbtn'.tr(context),
                        onPressed: () {
                          forgotCubit.forgotPasswordCheckEmail(
                              forgotCubit.phoneController.text);
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
