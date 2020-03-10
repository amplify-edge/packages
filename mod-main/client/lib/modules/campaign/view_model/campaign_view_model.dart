

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/campaign/data/campaign_model.dart';

class CampaignViewModel extends BaseModel{
  List<Campaign> _campaigns = mockCampaigns;

  List<Campaign> get campaigns => _campaigns;

  void navigateToReady(){
    Modular.to.pushNamed(Paths.ready);
  }

  void navigateToNotReady(){
    Modular.to.pushNamed(Paths.notReady);
  }
}