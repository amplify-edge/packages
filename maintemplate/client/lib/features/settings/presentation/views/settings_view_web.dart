import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';
import 'package:provider/provider.dart';

import '../../../../locator.dart';
import '../../settings.dart';

class SettingsViewWeb extends StatelessWidget {

  SettingsViewWeb({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title:Text("Settings"),
        leading: IconButton(icon:Icon( Icons.arrow_back), onPressed: (){
          locator<NavigationService>().pop();
        }),
      ),
      body: Column(children: [
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
      ]),
    );
  }
}
