import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_settings/mod_settings.dart';

void main() {
  CoreSettings.instance.registerModuleConfig(
    ModuleConfig(moduleID: "ExampleModuleID", moduleName: "Example Module")
      ..addModuleConfigItems(
        [
          ModuleConfigItemDropdown("key-dropdown", 0, "this is an example dropdown",
              items: ["eins", "zwei", "drei"]),
          ModuleConfigItemBool("key-bool", true, "test flag here"),
          ModuleConfigItemBool("key-bool2", true, "second flag here"),
        ],
      ),
  );

  CoreSettings.instance.registerModuleConfig(
    ModuleConfig(moduleID: "ExampleModuleID2", moduleName: "Example Module2")
      ..addModuleConfigItems(
        [
          ModuleConfigItemBool("key-bool2", true, "second flag here"),
          ModuleConfigItemBool("key-bool", true, "test flag here"),
          ModuleConfigItemDropdown("key-dropdown", 4, "this is an complete different dropdown from another module",
              items: ["eins", "zwei", "drei", "vier", "fünf"]),
        ],
      ),
  );

  runApp(ModularApp(module: AppModule()));
}

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  Widget get bootstrap => App();

  @override
  List<Router> get routers => [
        Router(
          "/",
          module: SettingsModule(),
        ),
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
