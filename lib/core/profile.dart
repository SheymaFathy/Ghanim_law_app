import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';

class UserData {
  static String? uId;
  static String? lang;
  static bool isGhost = false;
  static init() async {
    uId = await CacheHelper.getSaveData(key: "uId");
    lang = await CacheHelper.getSaveData(key: "LOCALE");

    if (await CacheHelper.getSaveData(key: "ghost") != null) {
      isGhost = await CacheHelper.getSaveData(key: "ghost");
    }
  }

  static initLang() async {
    lang = await CacheHelper.getSaveData(key: "LOCALE");
  }
}
