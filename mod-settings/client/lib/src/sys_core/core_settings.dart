import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mod_settings/src/sys_core/module_config_item.dart';

class CoreSettings extends ChangeNotifier {
  static final CoreSettings _instance = CoreSettings._internal();

  static CoreSettings get instance => _instance;

  CoreSettings._internal();

  /// this map contains all [ModuleConfig] classes from all submodules
  /// which have registered their settings here
  final Map<String, ModuleConfig> _moduleConfigs = Map<String, ModuleConfig>();

  List<ModuleConfig> get moduleConfigs => _moduleConfigs.values.toList();

  /// each module which want's to expose its settings have to register
  /// its [ModuleConfig] here
  registerModuleConfig(ModuleConfig configs) {
    print("ModuleConfig registered : ${configs.moduleID}, $configs}");
    _moduleConfigs[configs.moduleID] = configs;
    notifyListeners();
    configs.addListener(() {
      onModuleChange(configs.moduleID);
    });
  }

  /// this function fires if any config from any submodule has changed
  onModuleChange(String moduleID) {
    // this module has changed -> please save
    print("onModuleChange -> moduleID: $moduleID");
    notifyListeners();
  }
}

/// [ModuleConfig] is the base class for every module which needs to expose
/// it's settings to the settings gui. This module can be used for any DI
/// solutions and be consumed by a Consumer class as there are in
/// flutter_modular or provider as it's also a ChangeNotifier class.
///
/// A possible implementation could look like:
///
///     class MainModuleConfig extends ModuleConfigs {
///       @override
///       String moduleID = "MainModule";
///
///       MainModuleConfig() : super() {
///         this.setString("key", "value");
///         this.setInt("counter", 0, "description");
///       }
///     }
///
class ModuleConfig extends ChangeNotifier {
  String moduleID;
  String moduleName;
  Map<String, ModuleConfigItem> _configItems = Map();

  List<ModuleConfigItem> get configItems => _configItems.values.toList();

  ModuleConfig({@required this.moduleID, @required this.moduleName})
      : assert(moduleID != null),
        assert(moduleName != null);

  addModuleConfigItems(List<ModuleConfigItem> items) {
    items.forEach((item) {
      if (_configItems[item.key] != null) {
        print(
            "Warning ModuleConfigItem with key '${item.key}' already added! Ignoring... $item");
      } else {
        _configItems[item.key] = item;
      }
    });
  }

  ModuleConfigItemDropdown getModuleConfigItemDropdown(String key) {
    var item = _configItems[key];
    if (item == null) {
      print("Error: Key $key not found!");
      return null;
    }
    if (item is! ModuleConfigItemDropdown) {
      print(
          "Error: Value of key $key has not a ModuleConfigItemDropdown: ${item.runtimeType}}");
      return null;
    }
    return (item as ModuleConfigItemDropdown);
  }

  ModuleConfigItemBool getModuleConfigItemBool(String key) {
    var item = _configItems[key];
    if (item == null) {
      print("Error: Key $key not found!");
      return null;
    }
    if (item is! ModuleConfigItemBool) {
      print(
          "Error: Value of key $key has not a ModuleConfigItemBool: ${item.runtimeType}}");
      return null;
    }
    return item as ModuleConfigItemBool;
  }

  setDropDownValue(String key, int value) {
    var item = _configItems[key];
    if (item == null) {
      print("Error: Key $key not found!");
      return;
    }

    if (item is! ModuleConfigItemDropdown) {
      print(
          "Error: Value of key $key has not a ModuleConfigItemDropdown: ${item.runtimeType}}");
      return;
    }
    _configItems[key] =
        (item as ModuleConfigItemDropdown).copyWith(value: value);
    notifyListeners();
    print("dropdownvalueset: $value");
  }

  setBoolValue(String key, bool value) {
    var item = _configItems[key];
    if (item == null) {
      print("Error: Key $key not found!");
      return;
    }

    if (item is ModuleConfigItemDropdown) {
      print(
          "Error: Value of key $key has not a ModuleConfigItemBool: ${item.runtimeType}}");
      return;
    }
    _configItems[key] = (item as ModuleConfigItemBool).copyWith(value: value);
    notifyListeners();
  }

  @override
  String toString() {
    return "ModuleConfigs: { moduleID: $moduleID, _configs: $_configItems }";
  }
}


/*/// Concrete implementation of ModuleConfig with a String as value
class ModuleConfigItemString extends ModuleConfigItem<String> {
  ModuleConfigItemString(String key, String value, [String desc])
      : super(key, value, desc);
}

/// Concrete implementation of ModuleConfig with a int as value
class ModuleConfigItemInt extends ModuleConfigItem<int> {
  ModuleConfigItemInt(String key, int value, [String desc])
      : super(key, value, desc);
}*/

/// Concrete implementation of ModuleConfig with a dropdown as value
class ModuleConfigItemDropdown extends ModuleConfigItem<int> {
  final List<String> items;

  ModuleConfigItemDropdown(String key, int value, String desc,
      {@required this.items})
      : super(key, value, desc);

  ModuleConfigItemDropdown copyWith(
      {String key, int value, String desc, List<String> items}) {
    return ModuleConfigItemDropdown(
        key ?? this.key, value ?? this.value, description ?? this.description,
        items: items ?? this.items);
  }
}

/// Concrete implementation of ModuleConfig with a bool as value
class ModuleConfigItemBool extends ModuleConfigItem<bool> {
  ModuleConfigItemBool(String key, bool value, [String desc])
      : super(key, value, desc);

  ModuleConfigItemBool copyWith({String key, bool value, String desc}) {
    return ModuleConfigItemBool(
        key ?? this.key, value ?? this.value, description ?? this.description);
  }
}
