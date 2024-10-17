import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_router.dart';
import '../../../../../core/profile.dart';
import '../../../../../core/shared_preferences/cache_helper.dart';
import '../../../../../core/widget/app_bar.dart';

profileMyAppbar(context) => myAppBar(context, "profile".tr(context),
    actionWidget: UserData.uId != null
        ? IconButton(
            onPressed: () async {
              await CacheHelper.clearData(key: "uId").then((onValue) {
                GoRouter.of(context).go(AppRouter.kLogin);
                UserData.init();
              });
            },
            icon: const Icon(Icons.logout))
        : null);
