import 'package:get_it/get_it.dart';
import 'package:ghanim_law_app/features/auth/forgot_password/data/repo/forgot_pssword_repo.dart';
import 'package:ghanim_law_app/features/auth/login/data/repository/login_repo.dart';
import 'package:ghanim_law_app/features/auth/sign_up/data/repository/sign_up_repo.dart';
import 'package:ghanim_law_app/features/feedback/data/repo/fedback_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/repo/home_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/data/repo/my_order_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import 'package:ghanim_law_app/features/order_form/data/repo/add_order_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/data/repo/profile_repo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';
import 'package:ghanim_law_app/features/order_details/data/repo/my_order_details_repo.dart';

import 'package:ghanim_law_app/features/order_details/pre/view_model/cubit/my_order_details_cubit.dart';

import '../../features/order_form/pre/view_model/cubit/add_order_cubit.dart';
import '../../features/main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../AppLocalizations/app_localizations.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    getIt.registerFactory(() => LanguageCacheHelper());

    getIt.registerLazySingleton(() => SettingCubit(getIt()));
    getIt.registerLazySingleton(() => HomeCubit(getIt()));
    getIt.registerFactory(() => MainPageCubit());
    getIt.registerLazySingleton(() => AddOrderCubit(getIt()));
    getIt.registerLazySingleton(() => ProfileCubit(getIt()));
    getIt.registerLazySingleton(() => MyOrderCubit(getIt()));
    getIt.registerLazySingleton(() => MyOrderDetailsCubit(getIt()));
    getIt.registerSingleton<MyOrderDetailsRepo>(MyOrderDetailsRepoImp());

    getIt.registerSingleton<AddOrderRepo>(AddOrderRepoImp());
    getIt.registerSingleton<MyOrderRepo>(MyOrderRepoImp());
    getIt.registerSingleton<LoginRepo>(LoginRepoImp());
    getIt.registerSingleton<SignUpRepo>(SignUpRepoImp());
    getIt.registerSingleton<ForgotPsswordRepo>(ForgotPsswordRepoImp());
    getIt.registerSingleton<HomeRepoRepo>(HomeRepoRepoImp());
    getIt.registerSingleton<FedbackRepo>(FedbackRepoImp());
    getIt.registerSingleton<ProfileRepo>(ProfileRepoImp());
  }
}
