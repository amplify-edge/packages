
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_geo/app_module.dart';

import 'modules/map/views/map_view.dart';



void main() { 

  runApp(
    ModularApp(module: AppModule()));}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
    );
  }
}