import 'package:dio/dio.dart';
import 'package:namer_app/util/globals.dart' as globals;

import '../../models/location_model.dart';
import '../../models/place_model.dart';

class GoogleApiRepository {
  String queryAutoCompleteBuilder(String search) {
    return Uri.parse(
            "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?input=$search&key=${globals.googleApiKey}")
        .toString();
  }

  Future<List<Place>> getAutoComplete(String search) async {
    try {
      Response result = await Dio().get(
        queryAutoCompleteBuilder(search),
      );

      if (result.statusCode == 200) {
        List<Place> places = [];
        for (var item in result.data['predictions']) {
          places.add(Place.fromJson(item));
        }
        return places;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }

  String queryLocationDetailsBuilder(String placeId) {
    return Uri.parse(
            "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${globals.googleApiKey}")
        .toString();
  }

  Future<LocationModel> getLocationDetails(String placeId) async {
    try {
      Response result = await Dio().get(
        queryLocationDetailsBuilder(placeId),
      );
      if (result.statusCode == 200) {
        LocationModel locationModel = LocationModel(
            address: result.data['result']['formatted_address'],
            latitude: result.data['result']["geometry"]["location"]["lat"],
            longitude: result.data['result']["geometry"]["location"]["lng"]);

        return locationModel;
      } else {
        throw Exception(result.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
