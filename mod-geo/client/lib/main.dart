
import 'package:flutter/material.dart';

import 'modules/map/views/map_view.dart';



void main() { 

  runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapsView(),
    );
  }
}