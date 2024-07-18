import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/dio/dio_helper.dart';
import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';
import 'core/AppLocalizations/app_localizations.dart';
import 'core/constants/app_router.dart';
import 'core/get_it/service_locator.dart';
import 'core/profile.dart';
import 'features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await CacheHelper.init();
  await UserData.init();
  await DioHelper.init();
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SettingCubit>()..getSavedLanguage()),
        BlocProvider.value(value: getIt<MainPageCubit>()),
        BlocProvider.value(value: getIt<ProfileCubit>()..fetchProfileData()),
        BlocProvider.value(value: getIt<HomeCubit>()..getHomeData()),
      ],
      child: Builder(builder: (context) {
        final settingCubit = context.watch<SettingCubit>();
        context.watch<HomeCubit>();
        context.watch<ProfileCubit>();
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
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: settingCubit.state.locale.languageCode == 'ar'
                ? "Cairo"
                : "Rubik",
            scaffoldBackgroundColor: AppColors.backgroundColor,
            useMaterial3: true,
          ),
        );
      }),
    );
  }
}
