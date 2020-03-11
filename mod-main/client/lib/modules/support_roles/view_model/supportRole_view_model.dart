

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import '../services/supportRole_service.dart';
import '../data/supportRole_model.dart';
import '../../orgs/service/orgs_service.dart';

class SupportRoleViewModel extends BaseModel{
  final supportRoleService = Modular.get<SupportRoleService>();
  final orgService = Modular.get<OrgsService>();
  
 List<bool> _values = List<bool>.generate(Modular.get<SupportRoleService>().getSupportRoles().length, (index) => false);

 List<double> _minHours = List<double>.generate(Modular.get<SupportRoleService>().getSupportRoles().length, (index) => 0);

 List<SupportRole> get supportRoles => supportRoleService.getSupportRoles();
 List<bool> get values => _values; 
 List<double> get minHours => _minHours;


void selectMinHours(double value, int index){
  _minHours[index] = value;
  notifyListeners();
}

 void selectRole(value, int index){
   _values[index] = true;
   notifyListeners();
 }

  
  fetchOrgById(String id){
    return orgService.getOrgById(id);
  }
}