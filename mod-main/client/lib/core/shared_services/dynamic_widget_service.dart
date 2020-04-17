import 'package:flutter/material.dart';

typedef void CallbackInjection(Map<String, String> data, String selected);

class DynamicWidgetService {
  Map<String, String> selectedDropdownOptions = {};
}

class DynamicDropdownButton extends StatelessWidget {
  String _key;
  String _selected;
  final Map<String, String> _data;
  final CallbackInjection _callbackInjection;


  DynamicDropdownButton({Map<String, String> data, String selectedOption, CallbackInjection callbackInjection})
      : this._data = data,
        this._selected = selectedOption,
        this._callbackInjection = callbackInjection;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = _data.keys
        .map((question) =>
            DropdownMenuItem(child: Text(question), value: question))
        .toList();

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
        child: DropdownButton(
          hint: Text('Please Select an option from the list'),
          items: dropdownItems,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          isExpanded: true,
          value: this._selected,
          onChanged: this.onChangedCallback,
        ));
  }

  void onChangedCallback(String selected) {
    this._selected = selected;

    if (this._callbackInjection != null) {
      this._callbackInjection(this._data ,selected);
    }
  }
}
