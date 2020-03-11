import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import '../../orgs/service/orgs_service.dart';

class UserNeedsViewModel extends BaseModel {

  final orgService = Modular.get<OrgsService>();
  String _orgId;

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
    _orgId = id;
    return orgService.getOrgById(id);
  }

  void selectNeed(String key, value) {
    _value[key] = value;
    notifyListeners();
  }

  void navigateNext() {
    showActionDialogBox(
      onPressedNo: (){},
      onPressedYes: (){
        Modular.to.pushNamed(Paths.supportRoles.replaceAll(':id', _orgId));
      },
      title: "Support Role",
      description:
          "If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike ?",
    );
  }
}
