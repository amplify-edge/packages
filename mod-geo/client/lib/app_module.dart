

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main.dart';
import 'modules/geo_module.dart';
class AppModule extends MainModule{
  @override
  List<Bind> get binds => [
  ];

  
  @override
  // TODO: implement routers
  List<Router> get routers => [
     Router('/', module: GeoModule("/geo")),
  ];

  @override
  Widget get bootstrap => MyApp();


}