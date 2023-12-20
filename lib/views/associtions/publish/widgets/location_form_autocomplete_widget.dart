import 'package:flutter/material.dart';
import 'package:namer_app/models/location_model.dart';

Future<LocationModel?> ShowInputAutocomplete(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => LocationFormAutocomplete(),
  );
}

class LocationFormAutocomplete extends StatefulWidget {
  const LocationFormAutocomplete({super.key});

  @override
  State<LocationFormAutocomplete> createState() =>
      _LocationFormAutocompleteState();
}

class _LocationFormAutocompleteState extends State<LocationFormAutocomplete> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
