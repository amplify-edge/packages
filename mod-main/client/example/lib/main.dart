
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mod_main/modules/main_module.dart';


void main(){
  runApp(ModularApp(module : AppModule()));
}


class AppModule extends MainModule{
  @override
  List<Bind> get binds => [];

  
  @override
  Widget get bootstrap => App();
  
  @override
  List<Router> get routers => [
    Router("/", module: MainAppModule(
      baseRoute: '/',
      url: "http://[::1]:61146/#",
      urlNative: "http://[::1]:61146/#"
    )),
  ];
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
    );
  }
}