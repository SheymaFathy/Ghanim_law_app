import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/home_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/my_orders_page.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/settings/pre/view/settings_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  List<GButton> bottomNavBarTabs(context) => [
        GButton(
          icon: Icons.home,
          text: 'home'.tr(context),
          textStyle: const TextStyle(fontSize: 10.0),
        ),
        GButton(
          icon: Icons.list_alt,
          text: 'my-order'.tr(context),
          textStyle: const TextStyle(fontSize: 10.0),
        ),
        GButton(
          icon: Icons.person,
          text: 'profile'.tr(context),
          textStyle: const TextStyle(fontSize: 10.0),
        ),
        GButton(
          icon: Icons.settings,
          text: 'settings'.tr(context),
          textStyle: const TextStyle(fontSize: 10.0),
        ),
      ];
  bottomNavBarTabsChangeIndex(int index) {
    emit(state.copyWith(selectedNavBarIndex: index));
  }
}
