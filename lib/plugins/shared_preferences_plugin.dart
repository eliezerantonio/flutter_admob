import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPlugin {
  static Future<SharedPreferences> _getPref() async {
    return SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    final prefs = await _getPref();

    await prefs.setBool(key, value);
  }

  static Future<bool?> get(String key) async {
    final prefs = await _getPref();
    return prefs.getBool(key) ?? false;
  }
}
