import 'dart:convert';

import 'package:dio/dio.dart';
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
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Volunteer> get(String email) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}',
        'email': email
      };
      var dio = Dio();
      var response = await dio.request(
        'http://$url/api/v1/volunteers/volunteerEmail',
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
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
