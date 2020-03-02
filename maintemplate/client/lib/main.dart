import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/app_module.dart';
import 'package:maintemplate/layout_template.dart';
import 'package:maintemplate/locator.dart';
import 'package:provider/provider.dart';

import '././core/core.dart';
import 'modules/settings/settings.dart';

void main() {
  setupLocator();
  runApp(
    ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel(),
        child: ModularApp(module: AppModule())),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => LayoutTemplate(body: child),
      theme: themeData,
      darkTheme: ThemeData.dark(),
      themeMode: model.themeMode,
      initialRoute: Paths.home,
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('ur'),
      ],
    );
  }
}
