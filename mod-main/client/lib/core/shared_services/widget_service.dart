import 'package:flutter/material.dart';

class WidgetService {
  static DropdownButton createSelectBox(
      Function onChanged, String value, List<String> items) {
    return DropdownButton<String>(
      value: value,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 5,
      isExpanded: true,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}