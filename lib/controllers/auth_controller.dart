import 'package:shared_preferences/shared_preferences.dart';

import '../enums/auth_state_enum.dart';

class AuthController {

  static const String demoEmail =
      "test@gmail.com";

  static const String demoPassword =
      "Test@123";

  static Future<bool> login({

    required String email,
    required String password,
    required bool rememberMe,

  }) async {

    if (email == demoEmail &&
        password == demoPassword) {

      if (rememberMe) {

        final prefs =
            await SharedPreferences.getInstance();

        await prefs.setBool(
          'isLoggedIn',
          true,
        );

        await prefs.setString(
          'email',
          email,
        );
      }

      return true;
    }

    return false;
  }

  static Future<AuthState>
      checkLoginState() async {

    final prefs =
        await SharedPreferences.getInstance();

    bool isLoggedIn =
        prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      return AuthState.loggedIn;
    }

    return AuthState.loggedOut;
  }

  static Future<String> getSavedEmail()
  async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString('email') ?? '';
  }

  static Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();
  }
}