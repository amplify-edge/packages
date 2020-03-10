

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'views/campaign_view.dart';

class CampaignModule extends ChildModule{

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router(Paths.campaigns, child: (_, args) => CampaignView())
  ];


  static Inject get to => Inject<CampaignModule>.of();

}