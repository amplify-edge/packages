import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';
import 'package:maintemplate/modules/settings/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';


class SettingsViewWeb extends StatelessWidget {
  SettingsViewWeb({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final model = Provider.of<SettingsViewModel>(context);
    final env = model.envVariables;
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon( Icons.settings  ),
              SizedBox(width : 16),
              Text(AppLocalizations.of(context).tabSettings())
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.palette),
          title: Text(AppLocalizations.of(context).changeThemeSet()),
          trailing: DropdownButton<ThemeMode>(
            value: model.themeMode,
            onChanged: (ThemeMode value) {
              model.changeTheme(value);
            },
            items: ThemeMode.values
                .map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
              return DropdownMenuItem<ThemeMode>(
                value: value,
                child: Text(
                    value.toString().replaceAll(RegExp(r'ThemeMode.'), '')),
              );
            }).toList(),
          ),
        ),
         ListTile(
          leading: Icon(Icons.language),
          title:  Text(AppLocalizations.of(context).changeLanguageSet()),
          trailing: DropdownButton<Locale>(
            value: model.locale,
            onChanged: (Locale value) {
              model.changeLanguage(value);
            },
            items: model.supportedLocales
                .map<DropdownMenuItem<Locale>>((Locale value) {
              return DropdownMenuItem<Locale>(
                value: value,
                child: Text(
                    value.languageCode.getLanguage),
              );
            }).toList(),
          ),
        ),
        ListTile(
          title: Text("Channel"),
          subtitle: Text(env.channel),
        ),
        ListTile(
          title: Text("Url"),
          subtitle: Text(env.url),
        ),
        ListTile(
          title: Text("GitHash"),
          subtitle: Text(env.gitHash),
        ),
        ListTile(
          title: Text("Flutter channel"),
          subtitle: Text(env.flutterChannel),
        ),
      ]),
    );
  }
}
