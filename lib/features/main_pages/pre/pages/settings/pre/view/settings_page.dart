import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/setting_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            final settingCubit = context.read<SettingCubit>();
            return ListTile(
              leading: const Icon(Icons.language),
              title: const Text("language"),
              subtitle: const Text("You can switch between Arabic and English"),
              trailing: SizedBox(
                height: 200,
                width: 100,
                child: DropdownButton<String>(
                    isExpanded: true,
                    isDense: false,
                    value: state.locale.languageCode == "en"
                        ? "English"
                        : "Arabic",
                    items: ["English", "Arabic"].map((String items) {
                      return DropdownMenuItem<String>(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue == "English") {
                        settingCubit.changeLanguage("en");
                      } else if (newValue == "Arabic") {
                        settingCubit.changeLanguage("ar");
                      }
                    }),
              ),
            );
          },
        ),
      ],
    );
  }
}
