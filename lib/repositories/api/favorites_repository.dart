import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/favorites_model.dart';
import '../../util/token_service.dart';

class FavoritesRepository {
  final Dio _dio = Dio(); // Instance réutilisable de Dio
  final TokenService _tokenService = TokenService();

  Future<Favorites> getFavoritesByIdVolunteer(String id) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'id': id,
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/favoritesAnnouncement/favoritesAnnouncementById',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Favorites.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des favoris : ${response.statusMessage}');
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

  Future<Favorites> getFavoritesAnnouncementByVolunteerId(
      String idVolunteer) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'idVolunteer': idVolunteer,
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/favoritesAnnouncement/favoritesAnnouncementByVolunteerId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return Favorites.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des favoris : ${response.statusMessage}');
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

  Future<void> addFavorites(String idVolunteer, String idAnnouncement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'idVolunteer': idVolunteer,
        'idAnnouncement': idAnnouncement,
      };

      var response = await _dio.put(
        'http://${globals.url}/api/v1/favoritesAnnouncement/addAnnouncementToFavorites',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            'Erreur lors de la récupération des favoris : ${response.statusMessage}');
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

  Future<bool> isFavorite(String idVolunteer, String idAnnouncement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'idVolunteer': idVolunteer,
        'idAnnouncement': idAnnouncement,
      };

      var response = await _dio.get(
        'http://${globals.url}/api/v1/favoritesAnnouncement/isAnnouncementInFavorites',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Erreur lors de la récupération des favoris : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        bool refreshed = await _tokenService.tryRefreshToken();
        if (!refreshed) {
          await FirebaseAuth.instance.signOut();
          throw Exception('Session expirée. Utilisateur déconnecté.');
        }
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteFavorites(
      String idVolunteer, String idAnnouncement) async {
    await _tokenService.refreshTokenIfNeeded();

    try {
      String? token = await _tokenService.getToken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'idVolunteer': idVolunteer,
        'idAnnouncement': idAnnouncement,
      };
      print("response deleteFavoritesAnnouncement");

      var response = await _dio.put(
        'http://${globals.url}/api/v1/favoritesAnnouncement/deleteFavoritesAnnouncement',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print("response deleteFavoritesAnnouncement");
        return;
      } else {
        throw Exception(
            'Erreur lors de la récupération des favoris : ${response.statusMessage}');
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
