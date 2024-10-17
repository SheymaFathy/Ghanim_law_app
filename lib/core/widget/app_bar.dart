import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:go_router/go_router.dart';

AppBar myAppBar(BuildContext context, String title,
    {Widget? actionWidget, bool showAppbar = true}) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    elevation: 0.0,
    automaticallyImplyLeading: showAppbar,
    leading: showAppbar == false
        ? IconButton(
            onPressed: () {
              GoRouter.of(context).go(AppRouter.kHomeView);
            },
            icon: Icon(Icons.home),
            color: Theme.of(context).colorScheme.onSurface)
        : null,
    actions: actionWidget != null ? [actionWidget] : null,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),
    ),
    centerTitle: true,
  );
}
