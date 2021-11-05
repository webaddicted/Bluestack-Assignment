import 'package:flutter/cupertino.dart';
import 'package:tournament/utils/constant/pref_const.dart';
import 'package:tournament/utils/sp/sp_helper.dart';

class SPManager {
  static Future<String> getUserName<T>() async {
    var spValue = await SPHelper.getPreference(PrefConst.prefName, "");
    return spValue;
  }

  static void setUserName<T>(String userName) {
    SPHelper.setPreference(PrefConst.prefName, userName);
  }

  static Future<Set<String>> getAllKeys() async {
    var spValue = await SPHelper.getAllKeys();
    return spValue;
  }

  static Future<bool> removeKeys(String key) async {
    var spValue = await SPHelper.removeKey(key);
    return spValue;
  }

  static Future<bool> clearPref() async {
    var spValue = await SPHelper.clearPreference();
    return spValue;
  }

  static setLocale(String languageCode, String? countryCode) async {
    SPHelper.setPreference(PrefConst.prefLanguageCode, languageCode);
    SPHelper.setPreference(PrefConst.prefCountryCode, countryCode);
  }

  static Future<Locale> getLocale() async {
    String languageCode =
        await SPHelper.getPreference(PrefConst.prefLanguageCode, "") ?? "en";
    String countryCode =
        await SPHelper.getPreference(PrefConst.prefCountryCode, "") ?? "US";
    return _locale(languageCode, countryCode);
  }

  static Locale _locale(String languageCode, String countryCode) {
    return languageCode.isNotEmpty
        ? Locale(languageCode, countryCode)
        : const Locale('en', 'US');
  }
}
