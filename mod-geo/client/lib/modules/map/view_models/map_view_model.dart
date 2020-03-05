import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

class MapViewModel extends ChangeNotifier {
  // This should be current location
  LatLng _currentPosition = LatLng(50.8503, 4.3517);
  LatLng _cameraPosition;

  List<Marker> _markers = [
   
  ];

  LatLng get currentPosition => _currentPosition;
  LatLng get cameraPosition => _cameraPosition;
  List<Marker> get markers => _markers;

  void recenter(MapController mapController) {
    mapController.move(_currentPosition, 5);
  }

  void animateCameraPosition(LatLng point){
        _cameraPosition = point;
        notifyListeners();
  }

  void changeCenter({double lat, double long}) {
    _currentPosition = LatLng(lat, long);
    notifyListeners();
  }

  void addMarker({Marker marker}) {
    _markers.add(marker);
    notifyListeners();
  }
}
