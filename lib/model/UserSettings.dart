import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static Future saveSettings(
    bool showProfPic,
    String userId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$userId-showProfPic', showProfPic);
  }

  static Future<bool> getSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
