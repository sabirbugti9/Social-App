import 'package:shared_preferences/shared_preferences.dart';
//core preference (local database)
class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

//save data(set data) with any datatype
  static Future<bool> savaData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is double){
      return await sharedPreferences.setDouble(key, value);
    }
    else{
      return await sharedPreferences.setStringList(key, value);
    }
  }
//get data with a certain key
  static Object? getData({required String key}) {
    return sharedPreferences.get(key);
  }

//save (set) boolean value
  static Future<bool> putBoolean(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

//get boolean value
  static bool? getBoolean({required String key}) {
    return sharedPreferences.getBool(key);
  }

  //remove data with a certain key
  static Future<bool> removeData({required String key}) async{
   return await sharedPreferences.remove(key);
  }
  //check if the core preferences contains a certain value(key) or not
  static bool checkData({required String key}){
    return  sharedPreferences.containsKey(key);
  }

  //clear all data  (clear all the core preferences)
  static Future<bool> removeAllData() async{
    return await  sharedPreferences.clear();
  }
}
