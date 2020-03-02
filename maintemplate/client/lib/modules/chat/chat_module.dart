

import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';

import 'views/chat_view.dart';

class ChatModule extends ChildModule{
  @override
  List<Bind> get binds => [

  ];

  @override
  List<Router> get routers => [
    Router(Paths.chat, child: (context, args) => ChatView())
  ];

  static Inject get to => Inject<ChatModule>.of();

}