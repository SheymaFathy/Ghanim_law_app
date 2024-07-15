import 'package:get_it/get_it.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';

import '../../features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../AppLocalizations/app_localizations.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerFactory(() => LanguageCacheHelper());
    getIt.registerLazySingleton(() => SettingCubit(getIt()));
    getIt.registerLazySingleton(() => MainPageCubit());
  }
}
