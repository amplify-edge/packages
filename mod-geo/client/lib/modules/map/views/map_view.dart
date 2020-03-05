import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_geo/modules/map/view_models/map_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MapsView extends StatelessWidget {
  MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MapViewModel>.withConsumer(
      viewModel: MapViewModel(),
      onModelReady: (model) {
        model.fetchCampaigns();
        _setMarkers(model);
      },
      builder: (context, MapViewModel model, child) => Scaffold(
        body: ResponsiveBuilder(
          builder: (context, sizingInfo) => Stack(
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
              Positioned(
                top: 16,
                left: 16,
                child:(sizingInfo.screenSize.width > 720) ? SingleChildScrollView(      
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var campaign in model.campaigns) ...[
                            InkWell(
                              onTap: () {
                                _mapController.move(
                                    LatLng(campaign.location.latitude,
                                        campaign.location.longitude),
                                    5);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.my_location),
                                    SizedBox(width: 16),
                                    Text(campaign.campaignName),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                ) : 
                SingleChildScrollView(   
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var campaign in model.campaigns) ...[
                            InkWell(
                              onTap: () {
                                _mapController.move(
                                    LatLng(campaign.location.latitude,
                                        campaign.location.longitude),
                                    5);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.my_location),
                                    SizedBox(width: 16),
                                    Text(campaign.campaignName),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildPoi(MapViewModel model) {
  //   model.campaigns.map((campaign) {
  //     return ListTile(
  //       title: Text(campaign.campaignName),
  //       trailing: Icon(Icons.my_location),
  //       onTap: () {
  //         _mapController.move(
  //             LatLng(campaign.location.latitude, campaign.location.longitude),
  //             5);
  //       },
  //     );
  //   });
  // }

  void _setMarkers(MapViewModel model) {
    for (var campaign in model.campaigns) {
      model.addMarker(
          marker: Marker(
        height: 100,
        width: 100,
        point: LatLng(campaign.location.latitude, campaign.location.longitude),
        builder: (context) => InkWell(
          onTap: () {
            model.showCampagnDetails(campaign);
          },
          child: Column(
           
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(campaign.campaignName)),
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

  void _onMarkerTap(campaign) {}
}
