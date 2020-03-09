

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_view.dart';
import 'main.dart';

class AppModule extends MainModule{
  @override
  List<Bind> get binds => [];

  
  @override
  Widget get bootstrap => App();
  
  @override
  List<Router> get routers => [
    Router('/home', child: (_, args) => HomeView())
  ];

}