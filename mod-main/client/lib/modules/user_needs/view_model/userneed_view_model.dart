import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:mod_main/modules/user_needs/services/user_need_service.dart';
import '../../orgs/service/orgs_service.dart';

class UserNeedsViewModel extends BaseModel {
  final orgService = Modular.get<OrgsService>();
  final userNeedService = Modular.get<UserNeedService>();
  String _orgId;
  Org _org;
  List<dynamic> _userNeedsByGroup;

  get org => _org;
  get userNeedsByGroup => _userNeedsByGroup;

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

  initializeData(String orgId) {
    setBuzy(true);
    _orgId = orgId;
    _org = orgService.getOrgById(orgId);
    _userNeedsByGroup = userNeedService.getGroupedUserNeedsByOrgId(orgId);
    setBuzy(false);
  }

  void selectNeed(String key, value) {
    _value[key] = value;
    print(_value);
    notifyListeners();
  }

  void navigateNext() {
    showActionDialogBox(
      onPressedNo: () {
        Modular.to.pushNamed('/account/signup');
      },
      onPressedYes: () {
        Modular.to.pop();
        Modular.to.pushNamed(
            Modular.get<Paths>().supportRoles.replaceAll(':id', _orgId));
      },
      title: "Support Role",
      description:
          "If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike ?",
    );
  }
}
