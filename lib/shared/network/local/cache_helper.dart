import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({required String key, required bool val}) async {
    return await sharedPreferences!.setBool(key, val);
  }

  static bool? getData({required String key}) {
    return sharedPreferences!.getBool(key);
  }
}
