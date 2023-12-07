


import 'package:dio/dio.dart';

import '../../type/rules_type.dart';
import 'package:namer_app/util/globals.dart' as globals;

class UserRepository {



  Future<dynamic> createUser(RulesType rulesType) async {
    String type = "";
    if (rulesType == RulesType.USER_VOLUNTEER) {
      type = "USER_VOLUNTEER";
    } else if (rulesType == RulesType.USER_ASSOCIATION) {
      type = "USER_ASSOCIATION";
    }
    String token = globals.id;
    String url = globals.url;
    Response result = await Dio().post(
      "http://$url:8080/api/v1/users/create",
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "accept": "*/*",
        "rules": type
      }),
    );
    if(result.statusCode == 200){
      return result.statusCode;
    }else{
      throw Exception('Failed to load users');
    }
  }


}
