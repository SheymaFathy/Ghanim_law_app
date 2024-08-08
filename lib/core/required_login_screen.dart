import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/profile.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:go_router/go_router.dart';

class RequiredLoginScreen extends StatelessWidget {
  const RequiredLoginScreen({super.key, this.isAppBar = false});
  final bool isAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: isAppBar ? myAppBar(context, "login".tr(context)) : null,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("you_need_login".tr(context)),
              const SizedBox(
                height: 15,
              ),
              CustomBotton(
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  textColor: Theme.of(context).colorScheme.surface,
                  text: "login_now".tr(context),
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.kLogin);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

bool checkUserMethod() {
  UserData.init();
  if (UserData.uId != null) {
    return true;
  } else {
    return false;
  }
}
