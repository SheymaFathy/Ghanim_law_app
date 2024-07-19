import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/auth/widget/logo.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "feedback".tr(context)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthLogo(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "feedback_title".tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              maxLines: 15,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: "feedback_filed".tr(context)),
            )
          ],
        ),
      ),
    );
  }
}
