import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunnerMap extends StatelessWidget {
  final LatLng runnerLocation;
  final LatLng pickupLocation;

  const RunnerMap({
    super.key,
    required this.runnerLocation,
    required this.pickupLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: pickupLocation,
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('runner'),
          position: runnerLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueTeal),
          infoWindow: const InfoWindow(title: 'Runner'),
        ),
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickupLocation,
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      },
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
