import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view_model/cubit/sign_up_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/widget/app_bar.dart';

import 'sign_up_view_body.dart';
import 'widget/sign_up_erorr.dart';
import 'widget/sign_up_loading.dart';
import 'widget/sign_up_success.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, 'sign_up'.tr(context)),
        body: BlocProvider(
          create: (context) => SignUpCubit(getIt()),
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) async {
              if (state.signUpNewAccoutState == AuthRequestState.loading) {
                signUpLoadingWidget(context);
              } else if (state.signUpNewAccoutState == AuthRequestState.erorr) {
                signUpErorrWidget(context, state);
              } else if (state.signUpNewAccoutState ==
                  AuthRequestState.sucess) {
                final signUpCubit = context.read<SignUpCubit>();

                GoRouter.of(context).go(AppRouter.kLogin, extra: {
                  "email": signUpCubit.emailController.text,
                  "password": signUpCubit.passwordController.text
                });
                signUpSuccessWidget(context, state);
              }
            },
            builder: (context, state) {
              final signUpCubit = context.read<SignUpCubit>();
              return SignUpViewBody(signUpCubit: signUpCubit, state: state);
            },
          ),
        ));
  }
}

String? globalEmail;
String? globalPassword;
