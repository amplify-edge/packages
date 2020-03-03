import 'package:mod_ion/ion_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(ModularApp(module: AppModule()));

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(
          "/",
          module: IonModule("/module"),
        ),
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
