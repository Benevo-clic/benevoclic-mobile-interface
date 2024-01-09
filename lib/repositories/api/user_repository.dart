import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/user_model.dart';
import '../../type/rules_type.dart';
import '../../util/token_service.dart';

class UserRepository {
  final TokenService _tokenService = TokenService();

  String _mapRulesTypeToString(RulesType rulesType) {
    switch (rulesType) {
      case RulesType.USER_VOLUNTEER:
        return "USER_VOLUNTEER";
      case RulesType.USER_ASSOCIATION:
        return "USER_ASSOCIATION";
      default:
        return "UNKNOWN";
    }
  }

  Future<UserModel> createUser(RulesType rulesType) async {
    await _tokenService.refreshTokenIfNeeded();
    String type = _mapRulesTypeToString(rulesType);
    try {
      String? token = await _tokenService.getToken();
      Response result = await Dio().post(
        "http://${globals.url}/api/v1/users/create",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
          "rules": type
        }),
      );

      if (result.statusCode == 200) {
        return getUser();
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> connexion() async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      Response result = await Dio().post(
        "http://${globals.url}/api/v1/users/connect",
        options: Options(
            headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
      );

      if (result.statusCode == 200) {
        return getUser();
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    UserModel userModel = await getUserByEmail(user.email!);
    return userModel;
  }

  Future<dynamic> isUserExist(String email) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'email': email,
      };
      Dio dio = Dio(BaseOptions(
        baseUrl: 'http://${globals.url}/api/v1/',
        connectTimeout: Duration(seconds: 120), // 30 seconds in milliseconds
        receiveTimeout: Duration(seconds: 120), // 30 seconds in milliseconds
        // Autres configurations si nécessaire
      ));
      var response = await dio.request(
        'http://${globals.url}/api/v1/users/isUserExist',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getUserByEmail(String email) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'email': email,
      };
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/users/getUserByEmail',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> disconnect() async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      Response result = await Dio().post(
        "http://${globals.url}/api/v1/users/disconnect",
        options: Options(
            headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
      );

      if (result.statusCode == 200) {
        return 200;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var data = json.encode(user.toJson());
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/users/update',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteUser() async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      Response result = await Dio().delete(
        "http://${globals.url}/api/v1/users/delete",
        options: Options(
            headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
      );

      if (result.statusCode == 200) {
        return 200;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
