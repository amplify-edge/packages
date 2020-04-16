import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import '../services/support_role_service.dart';
import '../data/support_role_model.dart';
import '../../orgs/service/orgs_service.dart';

class SupportRoleViewModel extends BaseModel {
  final supportRoleService = Modular.get<SupportRoleService>();
  final orgService = Modular.get<OrgsService>();
  Org _org;

  List<bool> _values = List<bool>.generate(
      Modular.get<SupportRoleService>().getAll().length, (index) => false);

  List<double> _minHours = List<double>.generate(
      Modular.get<SupportRoleService>().getAll().length, (index) => 0);

  List<SupportRole> get supportRoles => supportRoleService.getAll();
  List<bool> get values => _values;
  List<double> get minHours => _minHours;
  Org get org => _org;

  void selectMinHours(double value, int index) {
    _minHours[index] = value;
    notifyListeners();
  }

  void selectRole(value, int index) {
    _values[index] = true;
    notifyListeners();
  }

  fetchOrgById(String id) {
    setBuzy(true);
    _org = orgService.getOrgById(id);
    setBuzy(false);
  }
}
