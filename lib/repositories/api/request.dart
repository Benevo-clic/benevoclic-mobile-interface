import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/announcement_model.dart';
import '../../type/rules_type.dart';

var url = "37.187.38.160";

Dio dio = Dio();

Future<int> createUser(RulesType rulesType) async {
  String type = "";
  if (rulesType == RulesType.USER_VOLUNTEER) {
    type = "USER_VOLUNTEER";
  } else if (rulesType == RulesType.USER_ASSOCIATION) {
    type = "USER_ASSOCIATION";
  }
  String token = globals.id;
  Response result = await dio.post(
    "http://$url:8080/api/v1/users/create",
    options: Options(headers: {
      "Authorization": "Bearer $token",
      "accept": "*/*",
      "rules": type
    }),
  );
  if(result.statusCode == 200){
    return 200;
  }else{
    throw Exception('Failed to load users');
  }
}



Future<Response> connexion() {
  String token = globals.id;
  return dio.post(
    "http://$url:8080/api/v1/users/connect",
    options:
        Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
  );
}

Future<Response> logoutAPI() {
  String token = globals.id;
  return dio.post(
    "http://$url:8080/api/v1/users/disconnect",
    options:
        Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
  );
}

Future<Response> createAsso(Map<String, Object> param) async {
  String token = globals.id;
  var r = await dio.post(
    "http://192.168.173.241:8080/api/v1/associations/createAssociation",
    options:
        Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
    data: param,
  );

  print(r);
  return r;
}

Future<Response> getAllAsso() {
  String token = globals.id;
  return dio.get(
    "http://$url:8080/api/v1/associations/allAssociations",
    options:
        Options(headers: {"Authorization": "Bearer $token", "accept": "*/*"}),
  );
}

Future<Response> createVolunteer(Map<String, Object> param) {
  String token = globals.id;
  return dio.post(
      "http://192.168.173.241:8080/api/v1/volunteers/createVolunteer",
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }),
      data: param);
}

Future<Response> getAllVolunteers() {
  String token = globals.id;
  return dio.get(
    "http://$url:8080/api/v1/volunteers/allVolunteers",
    options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    }),
  );
}


Future<Response> createAds(Map<String, Object> param) {
  String token = globals.id;
  return dio.post("http://$url:8080/api/v1/ads/createAds",
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "accept": "application/json"
      }),
      data: param);
}

Future<Response> getAllAds() {
  String token = globals.id;
  return dio.get(
    "http://$url:8080/api/v1/ads/allAds",
    options: Options(headers: {
      "Authorization": "Bearer $token",
      "accept": "application/json"
    }),
  );
}
