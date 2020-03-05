

import 'package:mod_geo/modules/map/mockdata/mock_campain.dart';
import 'package:mod_geo/modules/map/services/map_service_interface.dart';

class MockMapService implements IMapService{
  @override
  List<Campaign> fetchCampaigns() {
    return mockCampaigns;
  }

}