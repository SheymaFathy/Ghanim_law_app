import 'package:get_it/get_it.dart';

import '../../features/settings/pre/view_model/cubit/setting_cubit.dart';
import '../AppLocalizations/app_localizations.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerFactory(() => LanguageCacheHelper());
    getIt.registerLazySingleton(() => SettingCubit(getIt()));
  }
}
