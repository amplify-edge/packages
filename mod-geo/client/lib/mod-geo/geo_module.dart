
import 'package:flutter_modular/flutter_modular.dart';
import './views/map_view.dart';

class GeoModule extends ChildModule{
  @override
  List<Bind> get binds => [];


  @override
  List<Router> get routers => [
    Router('/geo', child:  (context, args) => MapsView())
  ];

  static Inject get to => Inject<GeoModule>.of();

}