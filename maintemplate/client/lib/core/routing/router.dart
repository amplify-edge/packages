import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintemplate/core/routing/route_data.dart';
import 'package:maintemplate/features/home/home.dart';
import 'package:maintemplate/features/settings/settings.dart';


class Router {
  static const String home = '/';
  static const String chat = '/chat';
  static const String ion = '/ion';
  static const String writer = '/writer';
  static const String settings = '/settings';
 

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // var routingData = settings.name.getRoutingData;
    var uri = Uri.parse(settings.name);
    var routingData = RoutingData(
      route: uri.path,
      queryParameters: uri.queryParameters
    );

    print(routingData.route);

    switch (routingData.route) {
      case Router.home:
        return _getPageRoute(HomeView(), routingData.route);
      case Router.chat:
        return _getPageRoute(HomeView(), routingData.route);
      case Router.ion:
        return _getPageRoute(HomeView(), routingData.route);
      case Router.writer:
        return _getPageRoute(HomeView(), routingData.route);
      case Router.settings:
        return _getPageRoute(SettingsView(), routingData.route);

      default:
    }
  }


  static PageRoute _getPageRoute(Widget child, String routeName) {
    return _FadeRoute(child: child, routeName: routeName);
  }
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            settings: RouteSettings(name: routeName),
            
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
