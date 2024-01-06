import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/models/filter_announcement_model.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/announcement_model.dart';
import '../../util/token_service.dart';

class AnnouncementRepository {
  final Dio _dio = Dio(); // Instance réutilisable de Dio
  final TokenService _tokenService = TokenService();

  Future<List<Announcement>> getAnnouncements() async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/announcement/allAnnouncement',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((announcement) => Announcement.fromJson(announcement))
            .toList();
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response
                .statusMessage}');
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

  Future<List<Announcement>> findAnnouncementAfterFilter(
      FilterAnnouncement filterAnnouncement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var data = json.encode(filterAnnouncement.toJson());

      var response = await _dio.get(
        'http://${globals.url}/api/v1/announcement/findAnnouncementByFilter',
        options: Options(headers: headers),
        data: data,
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((announcement) => Announcement.fromJson(announcement))
            .toList();
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Announcement>> findAnnouncementByTextSearch(
      String textSearch) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'textSearch': textSearch
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/announcement/findAnnouncementByTextSearch',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((announcement) => Announcement.fromJson(announcement))
            .toList();
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Announcement> unregisterVolunteer(
      String idAnnouncement, String idVolunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement,
        'volunteerId': idVolunteer
      };

      var response = await _dio.put(
        'http://${globals.url}/api/v1/announcement/unregisterVolunteer',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Announcement> registerVolunteerToAnnouncement(
      String idAnnouncement, String idVolunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement,
        'volunteerId': idVolunteer
      };

      var response = await _dio.put(
        'http://${globals.url}/api/v1/announcement/registerVolunteer',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Announcement> removeVolunteerFromWaitingList(
      String idAnnouncement, String idVolunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement,
        'volunteerId': idVolunteer
      };

      var response = await _dio.request(
        'http://${globals.url}/api/v1/announcement/removeVolunteerFromWaitingList',
        options: Options(method: 'PUT', headers: headers),
      );

      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Announcement> putAnnouncementInWatingList(
      String idAnnouncement, String idVolunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement,
        'volunteerId': idVolunteer
      };

      var response = await _dio.put(
        'http://${globals.url}/api/v1/announcement/updateAnnouncementVolunteersWaiting',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Announcement>> findAnnouncementByAssociation(
      FilterAnnouncement filterAnnouncement) async {
    return Future.delayed(Duration(seconds: 2), () async {
      await _tokenService.refreshTokenIfNeeded();

      try {
        String? token = await _tokenService.getToken();
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var data = json.encode(filterAnnouncement.toJson());

        var response = await _dio.get(
          'http://${globals.url}/api/v1/announcement/findAnnouncementByAssociationId',
          options: Options(headers: headers),
          data: data,
        );
        if (response.statusCode == 200) {
          return (response.data as List)
              .map((announcement) => Announcement.fromJson(announcement))
              .toList();
        } else {
          throw Exception(
              'Erreur lors de la récupération des annonces : ${response.statusMessage}');
        }
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  Future<List<Announcement>> getAnnouncementByAssociation(
      String idAssociation) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'associationId': idAssociation
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/announcement/announcementByAssociationId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((announcement) => Announcement.fromJson(announcement))
            .toList();
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response
                .statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      return [];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Announcement> deleteOneAnnouncement(String idAnnouncement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement
      };

      var response = await _dio.delete(
        'http://${globals.url}/api/v1/announcement/deleteAnnouncement',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Association> getAssociationById(String idAssociation) async {
    await _tokenService.refreshTokenIfNeeded();
    Future.delayed(Duration(seconds: 2));

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAssociation
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/announcement/AssociationByAnnouncementId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Association.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response
                .statusMessage}');
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

  Future<Announcement> updateAnnouncement(
      String idAnnouncement, Announcement announcement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': idAnnouncement
      };
      var data = json.encode(announcement.toJson());

      var response = await _dio.put(
        'http://${globals.url}/api/v1/announcement/updateAnnouncement',
        options: Options(headers: headers),
        data: data,
      );
      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Announcement> hiddenAnnouncement(String id, bool isVisible) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': id,
        'isVisible': isVisible
      };

      var response = await _dio.put(
        'http://${globals.url}/api/v1/announcement/updateAnnouncementIsVisible',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Announcement.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des annonces : ${response.statusMessage}');
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

  Future<Announcement> createAnnouncement(Announcement announcement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
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
}
