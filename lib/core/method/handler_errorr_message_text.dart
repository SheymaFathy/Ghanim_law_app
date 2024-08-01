import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

String erorrMessage(String message, context) {
  if (message.tr(context) != '') {
    return message.tr(context);
  } else {
    return message;
  }
}
