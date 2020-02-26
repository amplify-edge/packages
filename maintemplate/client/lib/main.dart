import 'package:flutter/material.dart';
import 'package:maintemplate/locator.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '././core/core.dart';
import 'features/settings/settings.dart';

void main() {
  setupLocator();
  runApp(
    
    ChangeNotifierProvider<SettingsViewModel>(
      create: (BuildContext context) =>
          SettingsViewModel(),
      child: App(),
    )
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context);
    
    print(model.themeMode);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: themeData,
        darkTheme: ThemeData.dark(),
        themeMode: model.themeMode,
        initialRoute: Router.home,
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      );
    
  }
}
