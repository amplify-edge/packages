

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';

import 'orgs/views/org_view.dart';
import 'user_needs/views/user_need_view.dart';
import 'userinfo/views/userinfo_view.dart';
import '../modules/orgs/service/orgs_service.dart';
import '../modules/support_roles/services/supportRole_service.dart';
import '../modules/support_roles/views/support_role_view.dart';

class MainAppModule extends ChildModule{
   @override
  List<Bind> get binds => [
      Bind((i) => OrgsService()),
      Bind((i) => SupportRoleService())
  ];

  
  @override
  List<Router> get routers => [
     Router(Paths.userInfo, child: (_, args) => UserInfoView()),
   Router(Paths.campaigns, child: (_, args) => OrgView()),
   Router(Paths.myNeeds, child: (_, args) => UserNeedsView(orgID: args.params['id'],)),
   Router(Paths.supportRoles, child: (_, args) => SupportRoleView(orgId: args.params['id'],))
  ];

  static Inject get to => Inject<MainAppModule>.of();
}