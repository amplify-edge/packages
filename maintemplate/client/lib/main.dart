import 'package:flutter/material.dart';
import 'package:maintemplate/locator.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '././core/core.dart';
import 'features/settings/settings.dart';

void main() {
  setupLocator();
  runApp(ServiceProvider());
}

class ServiceProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: "Saad"),
      ],
      child: ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel(),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final model = Provider.of<SettingsViewModel>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Router.home,
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: themeData,
        darkTheme: ThemeData.dark(),
        themeMode: model.themeMode,
 
    );
  }
}
