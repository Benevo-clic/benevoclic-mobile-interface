import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> refreshTokenIfNeeded() async {
    if (await isTokenExpired()) {
      await refreshToken();
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> refreshToken() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? newToken = await user.getIdToken(true);
      if (newToken != null) {
        DateTime expiryDate = DateTime.now().add(Duration(hours: 1));
        await saveTokenAndExpirationDate(newToken, expiryDate);
      }
    }
  }

  Future<bool> tryRefreshToken() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String? newToken = await user.getIdToken(true);
        if (newToken != null) {
          DateTime expiryDate = DateTime.now().add(Duration(hours: 1));
          await saveTokenAndExpirationDate(newToken, expiryDate);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearTokenAndExpirationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('token_expiry');
  }

  Future<void> saveTokenAndExpirationDate(
      String token, DateTime expiryDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('token_expiry', expiryDate.millisecondsSinceEpoch);
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? expiryDateMillis = prefs.getInt('token_expiry');
    if (expiryDateMillis != null) {
      DateTime expiryDate =
          DateTime.fromMillisecondsSinceEpoch(expiryDateMillis);
      return DateTime.now().isAfter(expiryDate);
    }
    return true;
  }
}
