



import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';


import 'views/ion_view.dart';

class IonModule extends ChildModule{
  @override
  List<Bind> get binds => [

  ];

  @override
  List<Router> get routers => [
    Router(Paths.ion, child: (context, args) => IonView())
  ];

  static Inject get to => Inject<IonModule>.of();

}