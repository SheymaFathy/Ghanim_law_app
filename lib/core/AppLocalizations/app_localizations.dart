import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared_preferences/cache_helper.dart';

class AppLocalizations {
  final Locale? locale;
  AppLocalizations({
    this.locale,
  });

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future loadJsonLanguage() async {
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedStrings[key] ?? "";
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}

class LanguageCacheHelper {
  Future<void> setCacheLanguageCode(String localeCode) async {
    await CacheHelper.saveData(key: "LOCALE", value: localeCode);
  }

  Future<String> getCacheLanguageCode() async {
    final cacheLanguageCode = await CacheHelper.getSaveData(key: "LOCALE");
    if (cacheLanguageCode != null) {
      return cacheLanguageCode;
    } else {
      return "en";
    }
  }
}
