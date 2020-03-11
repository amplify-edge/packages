

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import '../service/orgs_service.dart';
class OrgViewModel extends BaseModel{
  final OrgsService orgService = Modular.get<OrgsService>();

  List<Org> get orgs => orgService.getOrgs();

  void navigateToReady(){
    Modular.to.pushNamed(Paths.ready);
  }

  void navigateToNotReady(int index){
   
  }
}