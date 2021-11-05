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
}
