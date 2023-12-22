import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/user_model.dart';
import '../../type/rules_type.dart';

class UserRepository {
  final String url = "37.187.38.160:8080";

  Future<UserModel> createUser(RulesType rulesType) async {
    try {
      String type = "";
      if (rulesType == RulesType.USER_VOLUNTEER) {
        type = "USER_VOLUNTEER";
      } else if (rulesType == RulesType.USER_ASSOCIATION) {
        type = "USER_ASSOCIATION";
      }
      Response result = await Dio().post(
        "http://$url/api/v1/users/create",
        options: Options(headers: {
          "Authorization": "Bearer ${globals.id}",
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
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> connexion() async {
    try {
      Response result = await Dio().post(
        "http://$url/api/v1/users/connect",
        options: Options(headers: {
          "Authorization": "Bearer ${globals.id}",
          "accept": "*/*"
        }),
      );

      if (result.statusCode == 200) {
        return getUser();
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
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

  Future<dynamic> getUserByEmail(String email) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.id}',
        'email': email,
      };
      var dio = Dio();
      var response = await dio.request(
        'http://$url/api/v1/users/getUserByEmail',
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
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> disconnect() async {
    try {
      Response result = await Dio().post(
        "http://$url/api/v1/users/disconnect",
        options: Options(headers: {
          "Authorization": "Bearer ${globals.id}",
          "accept": "*/*"
        }),
      );

      if (result.statusCode == 200) {
        return 200;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.id}',
        'Content-Type': 'application/json'
      };
      var data = json.encode(user.toJson());
      var dio = Dio();
      var response = await dio.request(
        'http://$url/api/v1/users/update',
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
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteUser() async {
    try {
      Response result = await Dio().delete(
        "http://$url/api/v1/users/delete",
        options: Options(headers: {
          "Authorization": "Bearer ${globals.id}",
          "accept": "*/*"
        }),
      );

      if (result.statusCode == 200) {
        return 200;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
