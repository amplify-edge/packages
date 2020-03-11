

import 'package:mod_main/modules/orgs/data/org_model.dart';

class OrgsService{

  List<Org> _orgs = mockOrgs;

  Org getOrgById(String id){
    for(var org in _orgs){
      if(org.id == id){
        return org;
      }
    }
  }

  List<Org> getOrgs(){
    return _orgs;
  }
}