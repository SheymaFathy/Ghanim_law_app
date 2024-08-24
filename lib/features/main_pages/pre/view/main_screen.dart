import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'package:ghanim_law_app/core/widget/app_bar.dart';

import 'package:ghanim_law_app/features/main_pages/pre/view_model/cubit/main_page_cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../core/get_it/service_locator.dart';

import 'widget/profile_my_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainPageCubit>(),
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          final mainPageCubit = context.read<MainPageCubit>();

          return Scaffold(
            appBar: state.selectedNavBarIndex == 2
                ? profileMyAppbar(context)
                : myAppBar(
                    context,
                    mainPageCubit.appbarTitls[state.selectedNavBarIndex]
                        .tr(context)),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: mainPageCubit.bottomNavBarPages[state.selectedNavBarIndex],
            bottomNavigationBar: SalomonBottomBar(
              selectedItemColor: Theme.of(context).colorScheme.onSurface,
              backgroundColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              unselectedItemColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              currentIndex: mainPageCubit.state.selectedNavBarIndex,
              onTap: (index) {
                mainPageCubit.bottomNavBarTabsChangeIndex(index);
              },
              items: mainPageCubit.bottomNavBarTabs(context),
            ),
          );
        },
      ),
    );
  }
}
