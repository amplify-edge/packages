import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_ion/core/routes/paths.dart';
import 'package:mod_ion/src/call_sample/call_sample.dart';
import 'package:mod_ion/src/master_detail_home.dart';

class IonModule extends ChildModule {
  // not sure if this is the best way to store the current route statically
  // it works ... ideas welcome
  final String baseRoute;
  static String deviceID;
  static String userAgent;

  IonModule(this.baseRoute,
      {@required String deviceID, @required String userAgent}) {
    assert(deviceID != null);
    IonModule.deviceID = deviceID;
    assert(userAgent != null);
    IonModule.userAgent = userAgent;
    assert(baseRoute != null);
  }

  @override
  List<Bind> get binds => [
        Bind((i) => Paths(baseRoute)),
      ];

  // routes for child module are starting with '/', e.g. "/fullpage"
  // but to call inside this module the correct route
  // we have to take care about the base route
  // so '/' will go to it's app modules route not to the child route!
  // pattern for the child module is e.g.
  // navigator.pushNamed("/moduleBaseRoute/fullpage")
  @override
  List<ModularRouter> get routers => [
        ModularRouter("/",
            child: (context, args) => MasterDetailHome(
                  ip: "demo.cloudwebrtc.com",
                )),
        ModularRouter("/:id",
            child: (context, args) => MasterDetailHome(
                  ip: "demo.cloudwebrtc.com",
                  id: int.tryParse(args.params['id']) ?? -1,
                )),
      ];

  static Inject get to => Inject<IonModule>.of();
}
