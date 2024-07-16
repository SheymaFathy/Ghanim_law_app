import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              title: const Text("Language"),
              // subtitle: const Text("You can switch between Arabic and English"),
              children: [
                ListTile(
                  title: const Text("الانجليزية"),
                  onTap: () {
                    settingCubit.changeLanguage("en");

                  },
                  selected: state.locale.languageCode == "en",
                ),
                ListTile(
                  title: const Text("العربية"),
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
