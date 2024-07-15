import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'package:ghanim_law_app/features/auth/sign_up/pre/view/sign_up_screen.dart';

import 'core/AppLocalizations/app_localizations.dart';
import 'core/get_it/service_locator.dart';
import 'features/auth/login/pre/view/login_screen.dart';
import 'features/settings/pre/view_model/cubit/setting_cubit.dart';

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
      ],
      child: Builder(builder: (context) {
        context.watch<SettingCubit>().state;
        return MaterialApp(
          locale: BlocProvider.of<SettingCubit>(context).locale,
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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: const LoginScreen(),
        );
      }),
    );
  }
}
