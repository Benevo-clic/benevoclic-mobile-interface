import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namer_app/models/location_model.dart';

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
  List<dynamic> _places = [];

  Timer _debounce = Timer(Duration(milliseconds: 1), () {});

  Future<void> _searchAddress(String query) async {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(Duration(seconds: 1), () {
    });
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
          // ListView.builder(
          //     itemCount: _places.length,
          //     itemBuilder: (_, i) {
          //       var place = _places[i];
          //       return ListTile(
          //         leading: Icon(Icons.place),
          //         title: Text(place.description),
          //         onTap: () {
          //           print(place.description);
          //           Navigator.pop(context, place);
          //         },
          //       );
          //     })
        ],
      ),
    );
  }
}
