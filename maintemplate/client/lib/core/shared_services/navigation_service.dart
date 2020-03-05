
// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  


  Future<dynamic> navigateTo(String routeName, { Map<String, String> queryParams}){
    if(queryParams != null){
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateAndRemoveUntil(String routeName, String otherRoute, {Map<String, String> queryParams} ){
     if(queryParams != null){
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, ModalRoute.withName(otherRoute));
  }

   void  pop(){
    navigatorKey.currentState.pop();
  }
}