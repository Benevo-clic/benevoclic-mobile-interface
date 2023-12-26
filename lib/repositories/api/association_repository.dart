import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/association_model.dart';
import '../../util/token_service.dart';

class AssociationRepository {
  final String url = "37.187.38.160:8080";
  final TokenService _tokenService = TokenService();

  Future<Association> createAssociation(Association association) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = json.encode(association.toJson());
      var dio = Dio();

      var response = await dio.request(
        'http://${globals.url}/api/v1/associations/createAssociation',
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

  Future<bool> verifySiret(String siret) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'siret': siret,
      };
      var dio = Dio();

      var response = await dio.request(
        'http://${globals.url}/api/v1/associations/associationSiret',
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

  Future<Association> getAssociation(String id) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}',
        'id': id
      };
      var dio = Dio();
      var response = await dio.request(
        'http://$url/api/v1/associations/associationId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      print(response);

      if (response.statusCode == 200) {
        return Association.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
