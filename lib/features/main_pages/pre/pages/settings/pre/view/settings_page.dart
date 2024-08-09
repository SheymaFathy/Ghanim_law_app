import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:ghanim_law_app/core/required_login_screen.dart';
import 'package:ghanim_law_app/core/theme/theme.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';

import 'package:go_router/go_router.dart';

import '../view_model/cubit/setting_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.topCenter,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    leading: const Icon(Icons.language),
                    title: Text("language".tr(context)),
                    children: [
                      ListTile(
                        selectedColor: Colors.blue,
                        title: Text("eng".tr(context)),
                        onTap: () async {
                          context.read<SettingCubit>().changeLanguage("en");
                          await UserData.initLang();

                          getIt<HomeCubit>().getHomeData();
                        },
                        selected: state.locale.languageCode == "en",
                      ),
                      ListTile(
                        selectedColor: Colors.blue,
                        title: Text("arb".tr(context)),
                        onTap: () async {
                          context.read<SettingCubit>().changeLanguage("ar");
                          await UserData.initLang();

                          getIt<HomeCubit>().getHomeData();
                        },
                        selected: state.locale.languageCode == "ar",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.color_lens_outlined),
                  title: Text("Dark_Mode".tr(context)),
                  trailing: Switch(
                      value: ThemeService.darkModeValue,
                      onChanged: (val) {
                        context.read<SettingCubit>().toggleAppTheme(val);
                      }),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text("terms_and_privcy".tr(context)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kpolicy);
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (checkUserMethod())
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: const Icon(Icons.feedback_outlined),
                        title: Text("feedback".tr(context)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kFeedback);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.phone_in_talk),
                  title: Text("about".tr(context)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kAboutUs);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
