import 'package:client/mod-geo/view_models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

class MapView extends StatelessWidget {
  MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MapViewModel>.withConsumer(
      viewModel: MapViewModel(),
      onModelReady: (model) => _setMarkers(model),
      builder: (context, MapViewModel model, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      onTap: (point) {
                        model.addMarker(
                            marker: Marker(
                                height: 50,
                                width: 50,
                                point: point,
                                builder: (context) => IconButton(
                                    hoverColor: Colors.blue,
                                    onPressed: () {
                                      print(point);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                    ))));
                      },
                      center: model.currentPosition,
                      zoom: 5.0,
                    ),
                    mapController: _mapController,
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        // For example purposes. It is recommended to use
                        // TileProvider with a caching and retry strategy, like
                        // NetworkTileProvider or CachedNetworkTileProvider
                        tileProvider: NonCachingNetworkTileProvider(),
                      ),
                      MarkerLayerOptions(markers: model.markers)
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.my_location,
                    ),
                    onPressed: () {
                      model.recenter(_mapController);
                    }),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      _animateCameraPosition(
                         
                          title: "London Tax",
                          onPressed: () {
                            _mapController.move(LatLng(51.5074, 0.1278), 5);
                          }),
                          SizedBox(height: 8,),
                      _animateCameraPosition(
                        
                          title: "Shut Down Hambach Coal Mine",
                          onPressed: () {
                            _mapController.move(LatLng(53.5511, 9.9937), 5);
                          }),
                          SizedBox(height: 8,),
                      _animateCameraPosition(
                       
                          title: "Rio and Sau Polo",
                          onPressed: () {
                            _mapController.move(LatLng(14.2350, 51.9253), 5);
                          }),
                          SizedBox(height: 8,),
                      _animateCameraPosition(
                        
                          title: "NY State Shutdown",
                          onPressed: () {
                            _mapController.move( LatLng(40.7128, 74.0060), 5);
                          })
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animateCameraPosition({ String title, onPressed}) {
    return RaisedButton(
      color: Colors.blue,
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }

  void _setMarkers(MapViewModel model) {
    LatLng londonTaxPoint = LatLng(51.5074, 0.1278);
    LatLng shutDownHamBach = LatLng(53.5511, 9.9937);
    LatLng rio = LatLng(14.2350, 51.9253);
    LatLng nystate = LatLng(40.7128, 74.0060);
    model.addMarker(
        marker: Marker(
      height: 100,
      width: 100,
      point: londonTaxPoint,
      builder: (context) => InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("London Tax Point")),
                )),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.red,
            ),
          ],
        ),
      ),
    ));

    model.addMarker(
        marker: Marker(
      height: 100,
      width: 100,
      point: shutDownHamBach,
      builder: (context) => InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Shut Down Hambach Coal Mine")),
                )),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.red,
            ),
          ],
        ),
      ),
    ));

    model.addMarker(
        marker: Marker(
      height: 110,
      width: 110,
      point: rio,
      builder: (context) => InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("Rio and Sau Polo Strinkes to save amazon")),
                )),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.red,
            ),
          ],
        ),
      ),
    ));

    model.addMarker(
        marker: Marker(
      height: 100,
      width: 100,
      point: nystate,
      builder: (context) => InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("NY State Shutdown Pipeline")),
                )),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: Colors.red,
            ),
          ],
        ),
      ),
    ));
  }
}
