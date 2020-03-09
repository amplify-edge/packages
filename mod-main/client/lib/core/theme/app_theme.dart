import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

final overlayColor = const Color(0xff000000).withAlpha(150);

// #ff9705

ThemeData themeData = ThemeData(
  primaryColor: Color(hexColor('#a62d91')),
  primaryColorDark: Color(hexColor('#211535')),
  primaryColorLight: Color(hexColor('#b72b9b')),
  accentColor: Color(hexColor('#ff9300')),
  scaffoldBackgroundColor:  Color(hexColor('#b72b9b')),
  splashColor: Color(hexColor('#ccc')),
  textTheme: TextTheme(
    display1: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 20),
    display2: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 24),
    display3: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 32),
    display4: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 48),
    body1:  TextStyle(color: Color(hexColor('f2f2f2')), fontSize: 16),
  )
);



LinearGradient gradientHome = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
       Color(hexColor('f2f2f2')),
      Color(hexColor('c096ca')),
    ]);


LinearGradient gradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      themeData.primaryColorLight,
      themeData.primaryColor,
      themeData.primaryColorDark,
    ]);


LinearGradient gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      themeData.primaryColorLight,
      themeData.primaryColor,
    ]);

hexColor(String hexCode) {
  String colorst = '0xff' + hexCode.replaceAll('#', '');
  int color = int.parse(colorst);
  return color;
}


double headlineSize(SizingInformation sizingInfo){
  // Text size for tablet
  double width = sizingInfo.screenSize.width;
  if(width > 900){
    return 48.0;
  }
  
  if(width >= 600 && width < 900){
    return 32.0;
  }
  
  return 20.0;

}
