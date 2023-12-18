import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/user_model.dart';
import '../../type/rules_type.dart';

class UserRepository {
  final String url = "37.187.38.160:8080";

  Future<UserModel> createUser(RulesType rulesType) async {
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

    UserModel user = await getUser();

    if (result.statusCode == 200) {
      return user;
    } else {
      throw Exception(result.statusMessage);
    }
  }

  Future<UserModel> connexion() async {
    Response result = await Dio().post(
      "http://$url/api/v1/users/connect",
      options: Options(
          headers: {"Authorization": "Bearer ${globals.id}", "accept": "*/*"}),
    );

    UserModel user = await getUser();

    if (result.statusCode == 200) {
      return user;
    } else {
      throw Exception(result.statusMessage);
    }
  }

  Future<UserModel> getUser() async {
    var headers = {'Authorization': 'Bearer ${globals.id}'};
    var dio = Dio();
    var response = await dio.request(
      'http://$url/api/v1/users/getUsers',
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
  }

  Future<int> disconnect() async {
    Response result = await Dio().post(
      "http://$url/api/v1/users/disconnect",
      options: Options(
          headers: {"Authorization": "Bearer ${globals.id}", "accept": "*/*"}),
    );

    if (result.statusCode == 200) {
      return 200;
    } else {
      throw Exception(result.statusMessage);
    }
  }

  Future<int> deleteUser() async {
    Response result = await Dio().delete(
      "http://$url/api/v1/users/delete",
      options: Options(
          headers: {"Authorization": "Bearer ${globals.id}", "accept": "*/*"}),
    );

    if (result.statusCode == 200) {
      return 200;
    } else {
      throw Exception(result.statusMessage);
    }
  }
}
