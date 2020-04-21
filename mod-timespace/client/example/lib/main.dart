import 'package:flutter/material.dart';

import 'package:mod_timespace/mod_timespace.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Center(child: CountryPickerWidget(),)
      ),
      
    );
  }
}
