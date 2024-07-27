import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/home_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/my_orders_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/settings/pre/view/settings_page.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../pages/profile/pre/view/profile_page.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(const MainPageState());
  List<Widget> bottomNavBarPages = [
    const HomePage(),
    const MyOrdersPage(),
    const ProfilePage(),
    const SettingsPage()
  ];
  List<SalomonBottomBarItem> bottomNavBarTabs(context) => [
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text('home'.tr(context)),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.list_alt),
          title: Text('my-order'.tr(context)),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text('profile'.tr(context)),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.settings),
          title: Text('settings'.tr(context)),
        ),
      ];
  bottomNavBarTabsChangeIndex(int index) {
    emit(state.copyWith(selectedNavBarIndex: index));
  }
}
