import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final String _userName = "userName";
  static final String _authToken = "authToken";
  static final String _userEmail = "userEmail";
  static final String _userRole = "userRole";
  static final String _npUserID = "npUserID";
  static final String _userImage = "userImage";

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userName) ?? '';
  }

  static Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userName, value);
  }

  static Future<String> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userImage) ?? '';
  }

  static Future<bool> setUserImage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userImage, value);
  }

  static Future<String> getUserAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_authToken) ?? '';
  }

  static Future<bool> setNPUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_npUserID, value);
  }

  static Future<String> getNPUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_npUserID) ?? '';
  }

  static Future<bool> setUserAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_authToken, value);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userEmail) ?? '';
  }

  static Future<bool> setEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userEmail, userEmail);
  }

  static Future<String> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userRole) ?? '';
  }

  static Future<bool> setUserRole(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userRole, userEmail);
  }

  static Future<bool> clearAllPreferncesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(_userName);
    preferences.remove(_authToken);
    preferences.remove(_userEmail);
    preferences.remove(_userRole);
    preferences.remove(_userImage);
    preferences.clear();
    preferences.commit();
  }
}
