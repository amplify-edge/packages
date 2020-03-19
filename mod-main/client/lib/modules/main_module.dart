

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';

import 'orgs/service/orgs_service.dart';
import 'orgs/views/org_view.dart';
import 'splash/views/splash_view.dart';
import 'support_roles/services/supportRole_service.dart';
import 'support_roles/views/support_role_view.dart';
import 'user_needs/views/user_need_view.dart';
import 'userinfo/views/userinfo_view.dart';
import '../modules/org_manager/orgs/views/orgs_manager_view.dart';


class MainAppModule extends ChildModule{

  static String baseRoute;

  static String cutOffBaseRoute(String route) {
    if (route.indexOf(baseRoute) < 0) return route;
    return route.substring(
        route.indexOf(baseRoute) + baseRoute.length, route.length);
  }

  MainAppModule(String baseRoute) {
    if(baseRoute == '/'){
      baseRoute = '';
    }
    assert(baseRoute != null);
    MainAppModule.baseRoute = baseRoute;
  }

  @override
  List<Bind> get binds => [
      Bind((i) => Paths(baseRoute)),
      Bind((i) => OrgsService()),
      Bind((i) => SupportRoleService())
  ];
  
  @override
  List<Router> get routers => [
    Router("/", child: (_, args) => SplashView()),
    Router("/dashboard", child: (_, args) => OrgManagerView()),
    Router("/userInfo", child: (_, args) => UserInfoView()),
    Router("/orgs", child: (_, args) => OrgView()),
    Router("/myneeds/orgs/:id", child: (_, args) => UserNeedsView(orgID: args.params['id'],)),
    Router("/supportRoles/orgs/:id", child: (_, args) => SupportRoleView(orgId: args.params['id'],))
  ];

  static Inject get to => Inject<MainAppModule>.of();
}