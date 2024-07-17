import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/constants/app_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        final mainPageCubit = context.read<MainPageCubit>();
        return Scaffold(
          body: mainPageCubit.bottomNavBarPages[state.selectedNavBarIndex],
          bottomNavigationBar: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GNav(
              gap: 8,
              activeColor: AppColors.primeryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: AppColors.primeryColor.withOpacity(0.1),
              color: Colors.grey,
              tabs: mainPageCubit.bottomNavBarTabs(context),
              selectedIndex: mainPageCubit.state.selectedNavBarIndex,
              onTabChange: (index) {
                mainPageCubit.bottomNavBarTabsChangeIndex(index);
              },
            ),
          ),
        );
      },
    );
  }
}
