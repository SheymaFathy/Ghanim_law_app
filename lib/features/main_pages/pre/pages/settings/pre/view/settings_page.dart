import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import '../../../../../../../core/widget/app_bar.dart';
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
