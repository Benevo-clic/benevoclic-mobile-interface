import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/volunteer_model.dart';

class VolunteerRepository {
  final String url = "37.187.38.160:8080";

  Future<Volunteer> createVolunteer(Volunteer volunteer) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}'
      };
      var data = json.encode(volunteer.toJson());
      var dio = Dio();
      var response = await dio.request(
        'http://$url/api/v1/volunteers/createVolunteer',
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
}

