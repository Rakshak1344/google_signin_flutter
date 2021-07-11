// import 'dart:async';

// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   late SharedPreferences prefs;

//   Future<void> setBool(String key, bool value) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     prefs.setBool(key, value);
//   }

//   Future<bool> getBool(String key) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     return prefs.getBool(key);
//   }

//   Future<void> setString(String key, String value) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     prefs.setString(key, value);
//   }

//   Future<String> getString(String key) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     return prefs.getString(key);
//   }

//   Future<void> setStringList(String key, List<String> value) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     prefs.setStringList(key, value);
//   }

//   Future<List<String>> getStringList(String key) async {
//     if (prefs == null) prefs = await SharedPreferences?.getInstance();
//     return prefs.getStringList(key);
//   }

//   Future<bool> containsKey(String key) async {
//     if (prefs == null) prefs = await SharedPreferences.getInstance();
//     return prefs.containsKey(key);
//   }

//   Future<bool> clearSharedPrefs() async {
//     if (prefs == null) prefs = await SharedPreferences.getInstance();
//     return prefs.clear();
//   }
// }
