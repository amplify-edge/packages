import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:latlong/latlong.dart';
import 'package:mod_geo/modules/map/map.dart';
import 'package:mod_geo/modules/map/services/map_service_interface.dart';
import 'package:mod_geo/modules/map/services/mock_map_service.dart';

class MapViewModel extends ChangeNotifier {

  final IMapService _iMapService = Modular.get<MockMapService>();

  List<Campaign> _campaigns = [];

  // This should be current location
  LatLng _currentPosition = LatLng(50.8503, 4.3517);
  LatLng _cameraPosition;

  List<Marker> _markers = [];


  LatLng get currentPosition => _currentPosition;
  LatLng get cameraPosition => _cameraPosition;
  List<Campaign> get campaigns => _campaigns;
  List<Marker> get markers => _markers;


  void fetchCampaigns(){
    var result = _iMapService.fetchCampaigns();
    if(result != null){
      _campaigns = result;
      notifyListeners();
    }
  }

  Future<void> showCampagnDetails(Campaign campaign) async{
    print("show dialog");
    await showDialog<void>(
      context: Modular.navigatorKey.currentState.overlay.context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                SizedBox(height: 16),
                 Align(
                   alignment: Alignment.center,
                   child: Text("Campaign Details : " , style: TextStyle(fontWeight: FontWeight.bold),)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Campaign Name : " , style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width:8),
                    Text(campaign.campaignName),
                  ],
                ),

                 SizedBox(height: 16),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Campaign Affiliation : " , style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width:8),
                     Text(campaign.campaignAffiliation),
                    
                  ],
                ),
               
                SizedBox(height: 16),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Location : " , style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width:8),
                     Text("Lat(${campaign.location.latitude.toString()}),  Lng(${campaign.location.latitude.toString()})"),
                    
                  ],
                ),

                Divider(),
                Align(
                  alignment: Alignment.center,
                  child:
                    RaisedButton(
                      elevation: 0,
                      child: Text("Close"),onPressed: (){
                      Modular.navigatorKey.currentState.pop();
                    },)
                ),
                

              ]
            ),
          ),
        );
      },
    );
  }

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
