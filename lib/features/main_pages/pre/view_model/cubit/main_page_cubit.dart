import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/home_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/my_orders_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/settings/pre/view/settings_page.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../pages/profile/pre/view/profile_page.dart';
import '../../pages/settings/pre/view_model/cubit/setting_cubit.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(const MainPageState());
  List<Widget> bottomNavBarPages = [
    const HomePage(),
    const MyOrdersPage(),
    const ProfilePage(),
    const SettingsPage()
  ];
  List<String> appbarTitls = [
    'our_services',
    'my-order',
    'profile',
    'settings'
  ];
  List<SalomonBottomBarItem> bottomNavBarTabs(context) {
    final textStyle = TextStyle(
        fontSize: 12,
        fontFamily: getIt<SettingCubit>().state.locale.languageCode == 'ar'
            ? "Cairo"
            : "Rubik");
    return [
      SalomonBottomBarItem(
        icon: const Icon(Icons.home),
        title: Text(
          'home'.tr(context),
          style: textStyle,
        ),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.list_alt),
        title: Text('my-order'.tr(context), style: textStyle),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.person),
        title: Text('profile'.tr(context), style: textStyle),
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.settings),
        title: Text(
          'settings'.tr(context),
          style: textStyle,
        ),
      ),
    ];
  }

  bottomNavBarTabsChangeIndex(int index) {
    emit(state.copyWith(selectedNavBarIndex: index));
  }
}
