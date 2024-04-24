import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyToken = 'token';

  static Future initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setToken(String token) async {
    await _preferences.setString(_keyToken, token);
  }

  static String? getToken() {
    return _preferences.getString(_keyToken);
  }

  static Future clearToken() async {
    await _preferences.remove(_keyToken);
  }
}
