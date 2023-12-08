import 'package:dio/dio.dart';

import '../../type/rules_type.dart';
import 'package:namer_app/util/globals.dart' as globals;

class UserRepository {
  final String token = globals.id;
  final String url = globals.url;

  Future<dynamic> createUser(RulesType rulesType) async {
    String type = "";
    if (rulesType == RulesType.USER_VOLUNTEER) {
      type = "USER_VOLUNTEER";
    } else if (rulesType == RulesType.USER_ASSOCIATION) {
      type = "USER_ASSOCIATION";
    }
    Response result = await Dio().post(
      "http://$url:8080/api/v1/users/create",
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "accept": "*/*",
        "rules": type
      }),
    );
    if (result.statusCode == 200) {
      return result.statusCode;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<int> connexion() async {
    Response result = await Dio().post(
      "http://$url:8080/api/v1/users/connect",
      options:
          Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
    );

    if (result.statusCode == 200) {
      return 200;
    } else {
      throw Exception('Failed to connect');
    }
  }

  Future<int> disconnect() async {
    Response result = await Dio().post(
      "http://$url:8080/api/v1/users/disconnect",
      options:
          Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
    );

    if (result.statusCode == 200) {
      return 200;
    } else {
      throw Exception('Failed to disconnect');
    }
  }

  Future<int> deleteUser() async {
    Response result = await Dio().delete(
      "http://$url:8080/api/v1/users/delete",
      options:
          Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
    );

    if (result.statusCode == 200) {
      return 200;
    } else {
      throw Exception('Failed to delete');
    }
  }
}
