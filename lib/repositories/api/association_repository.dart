import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/association_model.dart';

class AssociationRepository {
  final String url = "37.187.38.160:8080";

  static Future<bool> verifySiretAssociation(String siret) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.id}',
        'siret': siret,
      };
      var dio = Dio();

      var response = await dio.request(
        'http://37.187.38.160:8080/api/v1/associations/associationSiret',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Association> createAssociation(Association association) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}'
      };
      var data = json.encode(association.toJson());
      var dio = Dio();

      var response = await dio.request(
        'http://$url/api/v1/associations/createAssociation',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return Association.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> verifySiret(String siret) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${globals.id}',
        'siret': siret,
      };
      var dio = Dio();

      var response = await dio.request(
        'http://$url/api/v1/associations/associationSiret',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
