import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';

class UserData {
  static String? uId;
  static String? lang;
  static bool isGhost = false;
  static init() {
    uId = CacheHelper.getSaveData(key: "uId");
    lang = CacheHelper.getSaveData(key: "LOCALE");
    if (CacheHelper.getSaveData(key: "ghost") != null) {
      isGhost = CacheHelper.getSaveData(key: "ghost");
    }
  }
}
