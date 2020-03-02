import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';
import 'package:maintemplate/modules/settings/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class SettingsViewWeb extends StatelessWidget {
  SettingsViewWeb({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Modular.to.pop();
                  }),
              SizedBox(width : 16),
              Text("Settings")
            ],
          ),
          ListTile(
            leading: Icon(Icons.palette),
            title: const Text('Change Theme'),
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
            title: const Text('Change Language'),
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
        ]),
      ),
    );
  }
}
