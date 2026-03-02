import 'dart:convert';
import 'dart:developer';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences prefs;
  static const String _keyUserId = 'user_id';
  static const String _keyUserData = 'user_data';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';

  SharedPreferencesHelper(this.prefs);

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  /// Get user ID
  String? getUserId() {
    return prefs.getString(_keyUserId);
  }

  Future<void> saveUserData(LoginModel userData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(userData.toJson());
    await prefs.setString(_keyUserData, jsonString);
  }

  /// Get user data
  Future<LoginModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserData);
    if (jsonString == null || jsonString.isEmpty) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return LoginModel.fromJson(jsonMap);
  }

  /// Save Bearer Token
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    log('Saving auth token: $token');
    await prefs.setString(_keyAuthToken, token);
  }

  Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    log('Saving refresh token: $token');
    await prefs.setString(_keyRefreshToken, token);
  }

  /// Get Bearer Token
  String? getAuthToken() {
    log('Getting auth token: ${prefs.getString(_keyAuthToken)}');
    return prefs.getString(_keyAuthToken);
  }

  String? getRefreshToken() {
    log('Getting refresh token: ${prefs.getString(_keyRefreshToken)}');
    return prefs.getString(_keyRefreshToken);
  }

  /// Remove Bearer Token
  Future<void> clearAuthToken() async {
    await prefs.remove(_keyAuthToken);
  }

  /// Clear all user info (logout)
  Future<void> clearUserData() async {
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserData);
    await prefs.remove(_keyAuthToken);
  }

  static const String _keySavedNotifications = 'saved_notifications';

  /// Save a notification
  Future<void> saveNotification(Map<String, dynamic> notificationJson) async {
    List<String> notifications =
        prefs.getStringList(_keySavedNotifications) ?? [];
    notifications.add(jsonEncode(notificationJson));
    await prefs.setStringList(_keySavedNotifications, notifications);
  }

  /// Get saved notifications
  List<Map<String, dynamic>> getSavedNotifications() {
    List<String> notifications =
        prefs.getStringList(_keySavedNotifications) ?? [];
    return notifications
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  /// Delete a notification by ID
  Future<void> deleteNotification(String id) async {
    List<String> notifications =
        prefs.getStringList(_keySavedNotifications) ?? [];
    notifications.removeWhere((e) {
      final map = jsonDecode(e);
      return map['id'] == id;
    });
    await prefs.setStringList(_keySavedNotifications, notifications);
  }
}
