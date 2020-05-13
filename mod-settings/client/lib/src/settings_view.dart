import 'package:flutter/material.dart';
import 'package:mod_settings/mod_settings.dart';

class SettingsViewNew extends StatefulWidget {
  @override
  _SettingsViewNewState createState() => _SettingsViewNewState();
}

class _SettingsViewNewState extends State<SettingsViewNew> {
  CoreSettings _coreSettings = CoreSettings.instance;

  @override
  void initState() {
    super.initState();
    _coreSettings.addListener(_updateUI);
  }

  @override
  void dispose() {
    super.dispose();
    _coreSettings.removeListener(_updateUI);
  }

  _updateUI() {
    print("_updateUI");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_coreSettings.moduleConfigs.isEmpty)
      return Center(
        child: Text("No settings found"),
      );

    var moduleSettings = _coreSettings.moduleConfigs.first;

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: 0.5,
          child: ListView(
            children: <Widget>[
              for (moduleSettings in _coreSettings.moduleConfigs)
                ..._getModuleSettingsList(moduleSettings),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getModuleSettingsList(ModuleConfig moduleSettings) {
    return [
      ListTile(
        title: Text(
          moduleSettings.moduleName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      ...moduleSettings.configItems.map((item) {
        if (item is ModuleConfigItemBool) {
          return SwitchListTile(
              title: Text(item.description),
              value: moduleSettings.getModuleConfigItemBool(item.key).value,
              onChanged: (v) => moduleSettings.setBoolValue(item.key, v));
        } else if (item is ModuleConfigItemDropdown) {
          return ListTile(
            title: Text(item.description),
            trailing: DropdownButton<int>(
              value: item.value,
              onChanged: (int value) {
                moduleSettings.setDropDownValue(item.key, value);
              },
              items: item.items
                  .map((String v) => DropdownMenuItem<int>(
                        value: item.items.indexOf(v),
                        child: Text(v),
                      ))
                  .toList(),
            ),
            onTap: () {},
          );
        } else {
          throw UnimplementedError();
        }
      }).toList(),
      Divider(color: Colors.black,thickness: 3,),
    ];
  }
}
