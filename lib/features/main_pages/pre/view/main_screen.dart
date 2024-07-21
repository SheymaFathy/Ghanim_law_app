import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view_model/cubit/add_order_cubit.dart';

import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/get_it/service_locator.dart';
import '../pages/home/pre/view_model/cubit/home_cubit.dart';
import '../pages/profile/pre/view_model/cubit/profile_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddOrderCubit>()),
        BlocProvider.value(
            value: getIt<MainPageCubit>()..bottomNavBarTabsChangeIndex(0)),
        BlocProvider.value(value: getIt<HomeCubit>()..getHomeData()),
        if (UserData.uId != null)
          BlocProvider.value(value: getIt<ProfileCubit>()..fetchProfileData()),
      ],
      child: BlocBuilder<MainPageCubit, MainPageState>(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
      ),
    );
  }
}
