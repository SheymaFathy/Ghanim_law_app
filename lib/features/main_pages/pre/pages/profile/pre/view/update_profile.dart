import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'package:ghanim_law_app/core/enum/enum.dart';

import '../../../../../../../core/widget/app_bar.dart';

import '../../../../../../../core/widget/material_banner_success.dart';
import '../../../../../../../core/widget/snake_bar_erorr.dart';
import '../view_model/cubit/profile_cubit.dart';
import 'widgets/update_profile_view_body_widget.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'edit_profile'.tr(context)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileUpdateRequestState == AuthRequestState.loading) {
            EasyLoading.show(
                status: 'loading...'.tr(context),
                maskType: EasyLoadingMaskType.black);
          } else if (state.profileUpdateRequestState ==
              AuthRequestState.sucess) {
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showMaterialBanner(materialBannerSuccess(
                  "Update Profile Sccessfuly", "profile".tr(context)));
          } else if (state.profileUpdateRequestState ==
              AuthRequestState.erorr) {
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBarErorr(
                  state.profileUpdatErorreMessage, "profile".tr(context)));
          }
        },
        builder: (context, state) {
          final profileCubit = context.read<ProfileCubit>();
          switch (state.profileRequestState) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.sucess:
              profileCubit.initUpdatePrfileData(state.profileModel!);
              return UpdateProfileViewBodyWidget(
                  profileCubit: profileCubit, state: state);
            case RequestState.erorr:
              return Center(child: Text(state.profileErorrMessage));
          }
        },
      ),
    );
  }
}
