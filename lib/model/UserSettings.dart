import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
  static Future saveSettings(
    bool showProfPic,
    bool recNot,
    String userId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$userId-showProfPic', showProfPic);
    await prefs.setBool('$userId-recNot', recNot);
  }

  static Future<bool> getSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
