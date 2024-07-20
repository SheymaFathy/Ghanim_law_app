import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view/widgets/profile_view_body_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';

import '../../../../../../../core/required_login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, "profile".tr(context)),
        body: checkUserMethod()
            ? BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  switch (state.profileRequestState) {
                    case RequestState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case RequestState.sucess:
                      return ProfileViewBodyWidget(state: state);
                    case RequestState.erorr:
                      return Center(child: Text(state.profileErorrMessage));
                  }
                },
              )
            : RequiredLoginScreen());
  }
}
