import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/color.dart';

class GoogleMapView extends StatefulWidget {
  double latitude;
  double longitude;
  String address;

  GoogleMapView(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.address});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {}

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: marron,
        ),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 12,
          ),
          markers: {
            Marker(
              markerId: MarkerId('1'),
              position: LatLng(widget.latitude, widget.longitude),
              infoWindow: InfoWindow(
                title: widget.address,
              ),
            ),
          },
        ));
  }
}
