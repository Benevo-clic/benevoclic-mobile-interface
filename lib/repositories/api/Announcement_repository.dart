import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/announcement_model.dart';

class AnnouncementRepository {
  final Dio _dio = Dio(); // Instance réutilisable de Dio

  Future<Announcement> createAnnouncement(Announcement announcement) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.id}'
      };
      var data = json.encode(announcement.toJson());

      var response = await _dio.post(
        'http://${globals.url}/api/v1/announcement/createAnnouncement',
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la création de l\'annonce : ${response
                .statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw Exception('Session expirée. Utilisateur déconnecté.');
      }
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception('Erreur inattendue : ${e.toString()}');
    }
  }
}
