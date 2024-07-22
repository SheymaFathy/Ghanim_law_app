import 'package:get_it/get_it.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/data/repo/forgot_pssword_repo.dart';
import 'package:ghanim_law_app/features/auth/login/data/repository/login_repo.dart';
import 'package:ghanim_law_app/features/auth/sign_up/data/repository/sign_up_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/feedback/data/repo/fedback_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/repo/home_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/repo/profile_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';

import '../../features/main_pages/pre/pages/order_form/pre/view_model/cubit/add_order_cubit.dart';
import '../../features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../AppLocalizations/app_localizations.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerFactory(() => LanguageCacheHelper());
    getIt.registerLazySingleton(() => SettingCubit(getIt()));
    getIt.registerLazySingleton(() => HomeCubit(getIt()));
    getIt.registerLazySingleton(() => MainPageCubit());
    getIt.registerLazySingleton(() => AddOrderCubit());
    getIt.registerLazySingleton(() => ProfileCubit(getIt()));
    getIt.registerSingleton<LoginRepo>(LoginRepoImp());
    getIt.registerSingleton<SignUpRepo>(SignUpRepoImp());
    getIt.registerSingleton<ForgotPsswordRepo>(ForgotPsswordRepoImp());
    getIt.registerSingleton<HomeRepoRepo>(HomeRepoRepoImp());
    getIt.registerSingleton<FedbackRepo>(FedbackRepoImp());
    getIt.registerSingleton<ProfileRepo>(ProfileRepoImp());
  }
}
