import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view/widgets/profile_view_body_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../../../../../../../core/required_login_screen.dart';
import '../../../../../../../core/widget/custom_erorr_page_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    checkUserMethod();
    return checkUserMethod()
        ? BlocProvider.value(
            value: getIt<ProfileCubit>()..fetchProfileData(),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state.profileRequestState == RequestState.erorr) {
                  if (state.profileErorrStatusCode != null &&
                      state.profileErorrStatusCode == 401) {
                    CacheHelper.clearData(key: 'uId');
                    checkUserMethod();
                  }
                }
              },
              builder: (context, state) {
                switch (state.profileRequestState) {
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case RequestState.sucess:
                    return ProfileViewBodyWidget(state: state);
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
          )
        : const RequiredLoginScreen();
  }
}
