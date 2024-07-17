import 'package:ghanim_law_app/core/shared_preferences/cache_helper.dart';

class UserData {
  static String? uId;
  static String? lang;
  static init() {
    uId = CacheHelper.getSaveData(key: "uId");
    lang = CacheHelper.getSaveData(key: "LOCALE");
  }
}
