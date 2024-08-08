import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';

class ThemeService {
  ThemeData lightMode(context) => ThemeData(
        useMaterial3: true,
        fontFamily:
            BlocProvider.of<SettingCubit>(context).state.locale.languageCode ==
                    "en"
                ? "Rubic"
                : "Cairo",
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade200,
          secondary: Colors.grey.shade400,
          onSurface: Colors.grey.shade900,
        ),
      );

  ThemeData darkMode(context) => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily:
            BlocProvider.of<SettingCubit>(context).state.locale.languageCode ==
                    "en"
                ? "Rubic"
                : "Cairo",
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade700,
          onSurface: Colors.grey.shade300,
        ),
      );
  static bool darkModeValue = false;
  // static Future themeInit() async {
  //   if (CacheHelper.getSaveData(key: "darkMode") == null) {
  //     CacheHelper.saveData(key: "darkMode", value: false);
  //   }
  //   darkModeValue = await CacheHelper.getSaveData(key: "darkMode");
  // }

  // static Future changeDarkMode() async {
  //   darkModeValue = !darkModeValue;

  //   await CacheHelper.saveData(key: "darkMode", value: darkModeValue);
  // }
}
