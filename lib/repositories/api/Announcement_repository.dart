import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/announcement_model.dart';

class AnnouncementRepository {
  Future<Announcement> createAnnouncement(Announcement announcement) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}'
      };
      var data = json.encode(announcement.toJson());
      var dio = Dio();
      var response = await dio.request(
        'http://${globals.url}/api/v1/announcement/createAnnouncement',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return Announcement.fromJson(response.data);
      } else {
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
