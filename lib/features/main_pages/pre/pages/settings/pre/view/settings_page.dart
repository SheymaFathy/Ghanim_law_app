import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../core/widget/app_bar.dart';
import '../../../feedback/pre/view/feed_back_screen.dart';
import '../view_model/cubit/setting_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final settingCubit = context.read<SettingCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              myAppBar(context, "settings".tr(context)),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text("Send Feedback"),
                trailing: UserData.lang == "ar"
                    ? const Icon(Icons.arrow_back_ios, size: 16)
                    : const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kFeedBack);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("about"),
                trailing: UserData.lang == "ar"
                    ? const Icon(Icons.arrow_back_ios, size: 16)
                    : const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kFeedBack);
                },
              ),
              ExpansionTile(
                expandedAlignment: Alignment.topCenter,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                leading: const Icon(Icons.language),
                title: Text("language".tr(context)),
                children: [
                  ListTile(
                    title: Text("eng".tr(context)),
                    onTap: () {
                      settingCubit.changeLanguage("en");
                    },
                    selected: state.locale.languageCode == "en",
                  ),
                  ListTile(
                    title: Text("arb".tr(context)),
                    onTap: () {
                      settingCubit.changeLanguage("ar");
                    },
                    selected: state.locale.languageCode == "ar",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
