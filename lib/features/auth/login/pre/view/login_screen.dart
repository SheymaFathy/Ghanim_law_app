import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_router.dart';
import '../../../../../core/widget/app_bar.dart';

import '../view_model/cubit/login_cubit.dart';
import 'login_view_body.dart';
import 'widget/login_erorr_widget.dart';
import 'widget/login_loading_widget.dart';
import 'widget/login_success_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.email, this.password});
  final String? email;
  final String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: myAppBar(
          context,
          'login'.tr(context),
        ),
        body: BlocProvider(
          create: (context) => LoginCubit(getIt()),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.loginState == AuthRequestState.loading) {
                loginLoadingWidget(context);
              } else if (state.loginState == AuthRequestState.erorr) {
                loginSnakeBarErorr(context, state);
              } else if (state.loginState == AuthRequestState.sucess) {
                CacheHelper.saveData(
                    key: 'uId', value: state.loginModel!.token!);

                UserData.init();
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                loginMaterialBannerWidget(context);
              }
            },
            builder: (context, state) {
              final loginCubit = context.read<LoginCubit>();
              if (email != null) {
                loginCubit.userNameController.text = email!;
                loginCubit.passwordController.text = password!;
              }
              return LoginViewBody(loginCubit: loginCubit);
            },
          ),
        ));
  }
}
