import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../method/handler_errorr_message_text.dart';
import '../responsive_text/app_style.dart';

class CustomErorrPageWidget extends StatelessWidget {
  const CustomErorrPageWidget({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });
  final String errorMessage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no-internet.png",
            width: MediaQuery.of(context).size.width / 2,
            //height: 100,
          ),
          Text(
            "Ooops".tr(context),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveFontSize(context, fontSize: 26)),
          ),
          Text(
            erorrMessage(errorMessage, context),
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: getResponsiveFontSize(context, fontSize: 22)),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                "Reload".tr(context),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
