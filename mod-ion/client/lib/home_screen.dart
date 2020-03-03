import 'dart:core';
import 'package:flutter/material.dart';
import 'src/loopback_sample.dart';
import 'src/get_user_media_sample.dart'
    if (dart.library.js) 'src/get_user_media_sample_web.dart';
import 'src/get_display_media_sample.dart';
import 'src/data_channel_sample.dart';
import 'src/route_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RouteItem> items;

  @override
  initState() {
    super.initState();
    _initItems();
  }

  _buildRow(context, item) {
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(item.title),
        onTap: () => item.push(context),
        trailing: Icon(Icons.arrow_right),
      ),
      Divider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter-WebRTC example'),
      ),
      body: new ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          itemCount: items.length,
          itemBuilder: (context, i) {
            return _buildRow(context, items[i]);
          }),
    );
  }

  _initItems() {
    items = <RouteItem>[
      RouteItem(
          title: 'GetUserMedia',
          push: (BuildContext context) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new GetUserMediaSample()));
          }),
      RouteItem(
          title: 'GetDisplayMedia',
          push: (BuildContext context) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new GetDisplayMediaSample()));
          }),
      RouteItem(
          title: 'LoopBack Sample',
          push: (BuildContext context) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new LoopBackSample()));
          }),
      RouteItem(
          title: 'DataChannel',
          push: (BuildContext context) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new DataChannelSample()));
          }),
    ];
  }
}
