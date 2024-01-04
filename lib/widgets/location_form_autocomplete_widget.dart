import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/models/place_model.dart';

import '../repositories/api/google_api_repository.dart';

Future<LocationModel?> ShowInputAutocomplete(BuildContext context) {
  return showDialog<LocationModel?>(
    context: context,
    builder: (BuildContext context) {
      return LocationFormAutocomplete();
    },
  );
}

class LocationFormAutocomplete extends StatefulWidget {
  const LocationFormAutocomplete({super.key});

  @override
  State<LocationFormAutocomplete> createState() =>
      _LocationFormAutocompleteState();
}

class _LocationFormAutocompleteState extends State<LocationFormAutocomplete> {
  List<Place> _places = [];

  Timer _debounce = Timer(Duration(milliseconds: 1), () {});

  Future<void> _searchAddress(String query) async {
    try {
      if (_debounce.isActive) _debounce.cancel();
      _debounce = Timer(Duration(milliseconds: 500), () async {
        if (query.isEmpty) return;
        final places = await GoogleApiRepository().getAutoComplete(query);
        setState(() {
          _places = places;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getPlaceDetails(String placeId) async {
    try {
      final location = await GoogleApiRepository().getLocationDetails(placeId);
      if (location != null) {
        FocusScope.of(context).unfocus(); // Ferme le clavier
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pop(context, location);
        });
      } else {
        FocusScope.of(context).unfocus(); // Ferme le clavier
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Rechercher',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchAddress,
              ),
              Positioned(
                right: 3,
                top: 5,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    FocusScope.of(context).unfocus(); // Ferme le clavier
                    Future.delayed(Duration(milliseconds: 100), () {
                      Navigator.pop(
                          context); // Ferme le dialogue après un court délai
                    });
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(_places[index].description),
                  onTap: () {
                    _getPlaceDetails(_places[index].placeId);
                    // Navigator.pop(context, _places[index].description);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
