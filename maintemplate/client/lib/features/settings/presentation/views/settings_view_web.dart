import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings.dart';

class SettingsViewWeb extends StatelessWidget {
  final model;
  SettingsViewWeb({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SettingsViewModel m = Provider.of<SettingsViewModel>(context);
    return Scaffold(
      body: Column(children: [
        ListTile(
          leading: Icon(Icons.palette),
          title: const Text('Change Theme'),
          trailing: DropdownButton<ThemeMode>(
            value: m.themeMode,
            onChanged: (ThemeMode value) {
               m.changeTheme(value);
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
    );
  }
}
