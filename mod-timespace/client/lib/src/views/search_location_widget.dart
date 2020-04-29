import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class OSMLocationData {
  final String displayName;
  final double lat;
  final double lon;

  OSMLocationData(this.displayName, this.lat, this.lon);

  static OSMLocationData fromJson(Map<String, dynamic> jsonMap) {
    String displayName = jsonMap["display_name"];
    double lat = double.tryParse(jsonMap["lat"]);
    double lon = double.tryParse(jsonMap["lon"]);
    return OSMLocationData(displayName, lat, lon);
  }

  @override
  String toString() {
    return "OSMLocationData { displayName: $displayName, lat: $lat, lon: $lon }";
  }
}

class SearchLocationWidget extends StatefulWidget {
  final ValueChanged<OSMLocationData> onLocationChanged;
  final InputDecoration decoration;

  const SearchLocationWidget({Key key, @required this.onLocationChanged, this.decoration = const InputDecoration()})
      : super(key: key);

  @override
  _SearchLocationWidgetState createState() => _SearchLocationWidgetState();
}

class _SearchLocationWidgetState extends State<SearchLocationWidget> {
  // actual location for the marker
  LatLng _actualLocation = LatLng(52.5170365, 13.3888599);

  // to control the map e.g. to move
  MapController _mapController = MapController();
  TextEditingController _searchTextController;

  // current suggestions
  List<OSMLocationData> places;

  // avoid search twice for same keyword
  String lastSearch;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      _getPlaces(_searchTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(children: <Widget>[
        _getTextField(),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          width: constraints.maxWidth,
          child: Stack(
            children: <Widget>[
              _getMap(),
              if (places != null && places.length > 0) _suggestionsList()
            ],
          ),
        ),
      ]);
    });
  }

  Widget _getTextField() => TextField(controller: _searchTextController, decoration: widget.decoration);

  /*
    suggestion list
   */
  Widget _suggestionsList() => ListView.builder(
        itemCount: places.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListTile(
            title: Text(places[index].displayName),
            onTap: () {
              var place = places[index];
              lastSearch = place.displayName;
              _searchTextController.text = place.displayName;
              setState(() {
                _actualLocation = LatLng(place.lat, place.lon);
                _mapController.move(_actualLocation, 12);
                places = null;
              });
              widget.onLocationChanged(place);
            },
          ),
        ),
      );

  /*
    flutter map from open street view
   */
  Widget _getMap() => FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _actualLocation,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _actualLocation,
                builder: (ctx) => new Container(
                  child: Icon(
                    Icons.panorama_fish_eye,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Future<List<OSMLocationData>> _getPlaces(String text) async {
    if (text.length <= 0 || lastSearch == text) return Future.value(null);

    /*
    This code was working, but now the page is down. Using mock data instead.

    final url =
        "https://nominatim.openstreetmap.org/search?q=${text.replaceAll(
        RegExp(' '), '+')}&format=json&addressdetails=1";
    final response = await http.get(url);
    final jsonObject = json.decode(response.body);
    final places = List<OSMLocationData>();
    (jsonObject as List).forEach((element) {
      places.add(OSMLocationData.fromJson(element));
    });
     */
    var places = List<OSMLocationData>();
    places.add(OSMLocationData("Berlin", 52.5170365, 13.3888599));
    places.add(OSMLocationData("Hamburg", 53.551086, 9.993682));
    places.add(OSMLocationData("Bremen", 53.079296, 8.801694));
    places.add(OSMLocationData("München", 48.135124, 11.581981));
    setState(() {
      lastSearch = text;
      this.places = places;
    });
    print(this.places);
    return places;
  }
}
