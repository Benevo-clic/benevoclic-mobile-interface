import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/volunteer_model.dart';

class VolunteerRepository {
  final String url = "37.187.38.160:8080";

  Future<Volunteer> createVolunteer(Volunteer volunteer) async {
    Response result = await Dio().post(
      "http://$url/api/v1/volunteers/create",
      data: json.encode(volunteer),
      options: Options(
        headers: {
          "Authorization": "Bearer ${globals.id}",
          "accept": "*/*",
        },
      ),
    );

    if (result.statusCode == 200) {
      return Volunteer.fromJson(result.data);
    } else {
      throw Exception(result.statusMessage);
    }
  }
}

// Future<UserModel> getUser() async {
//   var headers = {'Authorization': 'Bearer ${globals.id}'};
//   var dio = Dio();
//   var response = await dio.request(
//     'http://$url/api/v1/users/getUsers',
//     options: Options(
//       method: 'GET',
//       headers: headers,
//     ),
//   );
//   print(response.data);
//   if (response.statusCode == 200) {
//     return UserModel.fromJson(response.data);
//   } else {
//     throw Exception(response.statusMessage);
//   }
// }
