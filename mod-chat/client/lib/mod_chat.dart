library mod_chat;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_chat/core/routes/paths.dart';
import 'package:mod_chat/grpc_web_example/blocs/bloc.dart';
import 'package:mod_chat/grpc_web_example/pages/home.dart';
import 'package:mod_chat/grpc_web_example/pages/master_detail_home.dart';
export 'package:mod_chat/chat_module.dart';

class ChatModuleConfig {
  final String url;
  final String urlNative;

  ChatModuleConfig(this.url, this.urlNative);

  @override
  String toString() {
    return "ChatModuleConfig{url: $url}";
  }
}

class ChatModule extends ChildModule {
  String baseRoute;

  // we need device id statically for further use with static methods
  static String deviceID;

  static ChatModuleConfig chatModuleConfig;

  ChatModule(String baseRoute,
      {@required deviceID, @required url, @required urlNative}) {
    assert(deviceID != null);
    assert(baseRoute != null);
    assert(url != null);
    //assert(urlNative != null);
    this.baseRoute = baseRoute;
    ChatModule.deviceID = deviceID;

    ChatModule.chatModuleConfig = ChatModuleConfig(url, urlNative);
  }

  @override
  List<Bind> get binds => [
        Bind((i) => Paths(baseRoute)),
        Bind((i) => GRPCWebBloc()),
      ];

  // routes for child module are starting with '/', e.g. "/fullpage"
  // but to call inside this module the correct route
  // we have to take care about the base route
  // so '/' will go to it's app modules route not to the child route!
  // pattern for the child module is e.g.
  // navigator.pushNamed("/moduleBaseRoute/fullpage")
  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => MasterDetailHome()),
        Router("/:id", child: (context, args) => MasterDetailHome(id: int.tryParse(args.params['id']) ?? -1,)),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
