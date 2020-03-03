import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

//TODO: Uncomment when done.
//import 'screens/screenwidget.dart';

class ModChatModule extends ChildModule {
  Box messages;
  Box groups;

  ModChatModule(this.messages, this.groups);

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
        //TODO: Uncomment when ChatScreen is built.
        //Router("/", child: (context, args) => ChatScreen(messages, groups)),
      ];

  static Inject get to => Inject<ModChatModule>.of();
}
