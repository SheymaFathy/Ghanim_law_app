import 'package:flutter/material.dart';
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
      appBar: isAppBar ? myAppBar(context, "تسجيل الدخول") : null,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("تحتاج الي تسجيل الدخول للولوج الي هذه الصفحة"),
              const SizedBox(
                height: 15,
              ),
              CustomBotton(
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  text: "تسجيل الدخول",
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
  if (UserData.uId != null) {
    return true;
  } else {
    return false;
  }
}
