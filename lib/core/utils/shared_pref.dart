import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static setBoolKey(String key, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  static setStringKey(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  static getBoolKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  static getStringKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static removeStringKey(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}
