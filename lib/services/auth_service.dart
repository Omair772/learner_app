import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String usernameKey = 'registered_username';
  static const String emailKey = 'registered_email';
  static const String passwordKey = 'registered_password';
  static const String loggedInKey = 'is_logged_in';

  Future<Map<String, dynamic>> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (username.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Please fill in all fields.',
      };
    }

    if (!email.contains('@')) {
      return {
        'success': false,
        'message': 'Please enter a valid email.',
      };
    }

    if (password.length < 6) {
      return {
        'success': false,
        'message': 'Password must contain at least 6 characters.',
      };
    }

    final existingEmail = prefs.getString(emailKey);

    if (existingEmail == email.trim()) {
      return {
        'success': false,
        'message': 'This email is already registered.',
      };
    }

    await prefs.setString(usernameKey, username.trim());
    await prefs.setString(emailKey, email.trim());
    await prefs.setString(passwordKey, password);

    // Save user data for Profile / Persistence
    await prefs.setString(
      'user_data_username',
      username.trim(),
    );

    await prefs.setString(
      'user_data_email',
      email.trim(),
    );

    return {
      'success': true,
      'message': 'Account created successfully.',
    };
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString(emailKey);
    final savedPassword = prefs.getString(passwordKey);

    if (email.trim().isEmpty || password.trim().isEmpty) {
      return {
        'success': false,
        'message': 'Please enter email and password.',
      };
    }

    if (savedEmail == null || savedPassword == null) {
      return {
        'success': false,
        'message': 'No account found. Please sign up first.',
      };
    }

    if (email.trim() != savedEmail || password != savedPassword) {
      return {
        'success': false,
        'message': 'Incorrect email or password.',
      };
    }

    await prefs.setBool(loggedInKey, true);

    return {
      'success': true,
      'message': 'Login successful.',
    };
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loggedInKey, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }
}