import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import '../view_model/cubit/setting_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            final settingCubit = context.read<SettingCubit>();
            return ExpansionTile(
              leading: const Icon(Icons.language),
              title:  Text("language".tr(context)),
              // subtitle: const Text("You can switch between Arabic and English"),
              children: [
                ListTile(
                  title: Text("eng".tr(context)),
                  onTap: () {
                    settingCubit.changeLanguage("en");
                  },
                  selected: state.locale.languageCode == "en",
                ),
                ListTile(
                  title:  Text("arb".tr(context)),
                  onTap: () {
                    settingCubit.changeLanguage("ar");
                  },
                  selected: state.locale.languageCode == "ar",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
