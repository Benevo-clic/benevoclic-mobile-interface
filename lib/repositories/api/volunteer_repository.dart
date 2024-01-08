import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/volunteer_model.dart';
import '../../util/token_service.dart';

class VolunteerRepository {

  final TokenService _tokenService = TokenService();

  Future<Volunteer> createVolunteer(Volunteer volunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var data = json.encode(volunteer.toJson());
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/volunteers/createVolunteer',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return Volunteer.fromJson(response.data);
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

  Future<dynamic> getVolunteer(String id) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': id
      };
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/volunteers/volunteerId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );


      if (response.statusCode == 200) {
        return Volunteer.fromJson(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Association> followAssociation(String idAssociation) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'associationId': idAssociation
      };
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/volunteers/followAssociationByIdAssociation',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return Association.fromJson(response.data);
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

  Future<Association> unfollowAssociation(String idAssociation) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'associationId': idAssociation
      };
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/volunteers/unfollowAssociation',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return Association.fromJson(response.data);
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

  Future<Volunteer> updateVolunteer(Volunteer volunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var dio = Dio();
      var data = json.encode(volunteer.toJson());
      var response = await dio.request(
          'http://${globals.url}/api/v1/volunteers/updateVolunteer',
          options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data
      );

      if (response.statusCode == 200) {
        return Volunteer.fromJson(response.data);
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

  Future<void> deleteVolunteer() async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/volunteers/deleteVolunteer',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
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
}
