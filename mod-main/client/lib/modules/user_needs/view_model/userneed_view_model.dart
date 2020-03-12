import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import '../../orgs/service/orgs_service.dart';

class UserNeedsViewModel extends BaseModel {

  final orgService = Modular.get<OrgsService>();
  String _orgId;
  Org _org;

  get org => _org;

  Map<String, dynamic> _value = <String, dynamic>{
    "1": false,
    "2": false,
    "3": false,
    "4": false,
    "5": false,
    "6": false,
    "7": false,
    "8": false,
    "9": ''
  };

  Map<String, dynamic> get value => _value;

  fetchOrgById(String id){
    setBuzy(true);
    _orgId = id;
    _org = orgService.getOrgById(id);
    setBuzy(false);
  }

  void selectNeed(String key, value) {
    _value[key] = value;
    notifyListeners();
  }

  void navigateNext() {
    showActionDialogBox(
      onPressedNo: (){
        
      },
      onPressedYes: (){
        Modular.to.pop();
        Modular.to.pushNamed(Modular.get<Paths>().supportRoles.replaceAll(':id', _orgId));
      },
      title: "Support Role",
      description:
          "If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike ?",
    );
  }
}
