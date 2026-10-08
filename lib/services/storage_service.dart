import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String userKey = 'user_data';
  static const String tokenKey = 'auth_token';
  static const String favoritesKey = 'favorites';

  Future<void> saveUser({
    required String username,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final user = {
      'username': username,
      'email': email,
    };

    await prefs.setString(userKey, jsonEncode(user));

    // Also keep simple fields for compatibility with AuthService.
    await prefs.setString('user_data_username', username);
    await prefs.setString('user_data_email', email);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('user_data_username');
    final email = prefs.getString('user_data_email');

    if (username != null && email != null) {
      return {
        'username': username,
        'email': email,
      };
    }

    final data = prefs.getString(userKey);

    if (data == null || data.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(data);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(userKey);
    await prefs.remove('user_data_username');
    await prefs.remove('user_data_email');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<void> saveFavorites(
      List<Map<String, dynamic>> favorites,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      favoritesKey,
      jsonEncode(favorites),
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(favoritesKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(data);

      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(item),
        )
            .toList();
      }

      return [];
    } catch (_) {
      return [];
    }
  }

  Future<void> addFavorite(
      Map<String, dynamic> item,
      ) async {
    final favorites = await getFavorites();

    final itemId = item['id']?.toString();

    // Prevent duplicate favorites.
    final alreadyExists = favorites.any(
          (favorite) => favorite['id']?.toString() == itemId,
    );

    if (alreadyExists) {
      return;
    }

    favorites.add(item);

    await saveFavorites(favorites);
  }

  Future<void> removeFavorite(String id) async {
    final favorites = await getFavorites();

    favorites.removeWhere(
          (item) => item['id']?.toString() == id,
    );

    await saveFavorites(favorites);
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(favoritesKey);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(userKey);
    await prefs.remove('user_data_username');
    await prefs.remove('user_data_email');
    await prefs.remove(tokenKey);
    await prefs.remove(favoritesKey);
  }
}