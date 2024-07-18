import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "profile".tr(context)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children:  const [
           ProfileWidget(username: 'Shaimaa Fathy Zaki', email: 'freelance.ss44@gmail.com', phone: '+201119699941',),
          //
        ]),
      ),
    );
  }
}
