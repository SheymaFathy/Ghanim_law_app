import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'core/AppLocalizations/app_localizations.dart';
import 'core/constants/app_router.dart';
import 'core/get_it/service_locator.dart';
import 'core/profile.dart';
import 'core/theme/theme.dart';
import 'features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  ServiceLocator().init();
  await CacheHelper.init();
  await UserData.init();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SettingCubit>()..getSavedLanguage(),
      child: Builder(builder: (context) {
        final settingCubit = context.watch<SettingCubit>();
        return MaterialApp.router(
          builder: EasyLoading.init(),
          routerConfig: AppRouter.router,
          locale: settingCubit.state.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          title: "Ghanim Law Firm",
          theme: ThemeService().lightMode(context),
          darkTheme: ThemeService().darkMode(context),
          themeMode: true ? ThemeMode.dark : ThemeMode.light,
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
