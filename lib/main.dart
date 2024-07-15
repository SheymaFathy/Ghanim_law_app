import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';

import 'core/AppLocalizations/app_localizations.dart';
import 'core/get_it/service_locator.dart';

import 'features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import 'features/main_pages/pre/view/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SettingCubit>()..getSavedLanguage()),
        BlocProvider.value(value: getIt<MainPageCubit>()),
      ],
      child: Builder(builder: (context) {
        final settingCubit = context.watch<SettingCubit>();
        return MaterialApp(
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
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: settingCubit.state.locale.languageCode == 'ar'
                ? "Cairo"
                : "Rubik",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainScreen(),
        );
      }),
    );
  }
}
