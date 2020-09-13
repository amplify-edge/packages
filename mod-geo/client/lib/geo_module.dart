

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_geo/core/routes/paths.dart';
import 'package:mod_geo/modules/map/services/mock_map_service.dart';
import 'package:mod_geo/modules/map/views/master_detail_home.dart';
import 'modules/map/map.dart';


class GeoModule extends ChildModule{

  final String baseRoute;


  GeoModule(this.baseRoute) {
    assert(baseRoute != null);
  }

  @override
  List<Bind> get binds => [
    Bind((i) => Paths(baseRoute)),
    Bind((i) => MockMapService()),
  ];


  @override
  List<Router> get routers => [
    Router('/', child:  (context, args) => MasterDetailHome()),
    Router('/:id', child:  (context, args) => MasterDetailHome( id: int.tryParse(args.params['id']) ?? -1,)),
  ];

  static Inject get to => Inject<GeoModule>.of();

}