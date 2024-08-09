import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../shared_preferences/cache_helper.dart';

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
          brightness: Brightness.light,
          surface: Colors.grey.shade300,
          primary: Colors.grey.shade900,
          // secondary: Colors.grey.shade400,
          onSurface: Color(0xff000000),
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
          brightness: Brightness.dark,
          surface: Color(0xff000000),
          primary: Colors.grey.shade300,
          //  secondary: Colors.grey.shade700,
          onSurface: Colors.grey.shade300,
        ),
      );
  static bool darkModeValue = false;
  static Future themeInit() async {
    if (CacheHelper.getSaveData(key: "darkMode") == null) {
      CacheHelper.saveData(key: "darkMode", value: false);
    }
    darkModeValue = await CacheHelper.getSaveData(key: "darkMode");
  }

  static Future changeDarkMode() async {
    darkModeValue = !darkModeValue;

    await CacheHelper.saveData(key: "darkMode", value: darkModeValue);
  }
}
