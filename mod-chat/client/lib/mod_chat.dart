library mod_chat;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_chat/grpc_web_example/blocs/bloc.dart';
import 'package:mod_chat/grpc_web_example/blocs/bloc_provider.dart';
import 'package:mod_chat/grpc_web_example/grpc_web_view.dart';
export 'chat_module.dart';

class ChatModule extends ChildModule {
  // not sure if this is the best way to store the current route statically
  // it works ... ideas welcome
  static String baseRoute;

  // we need device id statically for further use with static methods
  static String deviceID;

  static String cutOffBaseRoute(String route) {
    if (route.indexOf(baseRoute) < 0) return route;
    return route.substring(
        route.indexOf(baseRoute) + baseRoute.length, route.length);
  }

  ChatModule(String baseRoute, {@required deviceID}) {
    assert(deviceID != null);
    assert(baseRoute != null);
    ChatModule.baseRoute = baseRoute;
    ChatModule.deviceID = deviceID;
  }

  @override
  List<Bind> get binds => [];

  // routes for child module are starting with '/', e.g. "/fullpage"
  // but to call inside this module the correct route
  // we have to take care about the base route
  // so '/' will go to it's app modules route not to the child route!
  // pattern for the child module is e.g.
  // navigator.pushNamed("/moduleBaseRoute/fullpage")
  @override
  List<Router> get routers => [
        Router(
          "/",
          child: (context, args) => BlocProvider<GRPCWebBloc>(
            bloc: GRPCWebBloc(),
            child: GRPCWebApp(),
          ),
        ),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
