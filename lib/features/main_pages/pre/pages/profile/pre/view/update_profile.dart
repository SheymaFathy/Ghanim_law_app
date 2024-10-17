import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/get_it/service_locator.dart';
import '../../../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../../../core/widget/app_bar.dart';

import '../../../../../../../core/widget/custom_erorr_page_widget.dart';
import '../../../../../../../core/widget/custom_snackbar_widget.dart';
import '../view_model/cubit/profile_cubit.dart';
import 'widgets/update_profile_view_body_widget.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'edit_profile'.tr(context)),
      body: BlocProvider.value(
        value: getIt<ProfileCubit>(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.profileUpdateRequestState == AuthRequestState.loading) {
              EasyLoading.show(
                  status: 'loading...'.tr(context),
                  maskType: EasyLoadingMaskType.black);
            } else if (state.profileUpdateRequestState ==
                AuthRequestState.sucess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBarWidget(
                    "update_profile_success".tr(context),
                    Theme.of(context).colorScheme.surface));

              GoRouter.of(context).pop();
            } else if (state.profileUpdateRequestState ==
                AuthRequestState.erorr) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBarWidget(
                    erorrMessage(state.profileUpdatErorreMessage, context),
                    Colors.red));
            }
          },
          builder: (context, state) {
            final profileCubit = context.read<ProfileCubit>();
            switch (state.profileRequestState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.sucess:
                profileCubit.initUpdatePrfileData(state.profileModel!, context);
                return UpdateProfileViewBodyWidget(
                    profileCubit: profileCubit, state: state);
              case RequestState.erorr:
                return CustomErorrPageWidget(
                  onTap: () {
                    context.read<ProfileCubit>().fetchProfileData();
                  },
                  errorMessage: state.profileErorrMessage,
                );
            }
          },
        ),
      ),
    );
  }
}
