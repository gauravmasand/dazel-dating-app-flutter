import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/MainAuth.dart';

bool isUserLoggedInFlag = false;

class SharesPrefs {
  static const _key = 'user_data';
  static const _keyMatchesListData = 'matches_list_data';

  static Future<Map<String, dynamic>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key) ?? '{}';
    return jsonDecode(jsonString);
  }

  static Future<void> _saveUserData(Map<String, dynamic> jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(jsonData);
    prefs.setString(_key, jsonString);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    return await _getUserData();
  }

  static Future<void> setUserData(Map<String, dynamic> newData) async {
    final currentData = await _getUserData();
    currentData.addAll(newData);
    await _saveUserData(currentData);
  }

  static Future<T?> getValue<T>(String key) async {
    final userData = await _getUserData();
    return userData[key] as T?;
  }

  static Future<void> setValue<T>(String key, T value) async {
    final userData = await _getUserData();
    userData[key] = value;
    await _saveUserData(userData);
  }

  static Future<bool> checkUserLoggedIn() async {
    final userData = await getUserData();
    bool isLoggedIn = userData.isNotEmpty;
    isUserLoggedInFlag = isLoggedIn;
    return isLoggedIn;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    isUserLoggedInFlag = false;
  }

  // For Matches
  static Future<List<String>> getMatchesList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyMatchesListData) ?? '[]';
    return List<String>.from(jsonDecode(jsonString));
  }


  static Future<void> setMatchesList(List<String> jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(jsonData);
    prefs.setString(_keyMatchesListData, jsonString);
  }

  static Future<void> updateMatchesList(String newData) async {
    final currentData = await getMatchesList() ?? <String>[];
    currentData.add(newData);
    await setMatchesList(currentData);
  }

  static Future<void> clearMatchesList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyMatchesListData);
  }

  static Future<bool> isUserIdInMatchesList(String userId) async {
    final matchesList = await getMatchesList();
    return matchesList.contains(userId);
  }

}

