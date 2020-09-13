

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryPickerWidget extends StatelessWidget {
  final ValueChanged<CountryCode> onCountryChanged;

  const CountryPickerWidget({Key key, this.onCountryChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
         onChanged: onCountryChanged,
         dialogSize: MediaQuery.of(context).size*0.5,
         
        //  builder: (CountryCode countryCode){
        //    return ListTile(
        //      leading: Image.asset(
        //             countryCode.flagUri,
        //             package: 'country_code_picker',
        //             width: 32.0,
        //           ),
        //      title: Text(countryCode.name),
        //      trailing: Icon(Icons.arrow_drop_down),
        //    );
        //  },
        padding: EdgeInsets.all(8),
         showCountryOnly: true,
         showOnlyCountryWhenClosed: true,
         alignLeft: false,
       );
  }
}