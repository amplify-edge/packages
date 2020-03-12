

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main.dart';
import './modules/main_module.dart';
class AppModule extends MainModule{
  @override
  List<Bind> get binds => [];

  
  @override
  Widget get bootstrap => App();
  
  @override
  List<Router> get routers => [
    Router("/", module: MainAppModule("/")),
  ];

}