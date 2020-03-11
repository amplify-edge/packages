// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:maintemplate02/custom_master_detail.dart';
import 'package:maintemplate02/home_page.dart';
import 'package:maintemplate02/login_page.dart';
import 'package:maintemplate02/master_detail.dart';
import 'package:maintemplate02/responsive_scaffold.dart';

class Routes {
  static final String home = "/";
  static final String login = "/login";
  static final String responsiveScaffold = "/responsiveScaffold";
  static final String masterDetail = "/masterDetail";
  static final String customMasterDetail = "/customMasterDetail";
}

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(Routes.home, child: (_, args) => HomePage()),
        Router("${Routes.login}/:user",
            child: (_, args) => LoginPage(
                  user: args.params['user'],
                )),
        Router(
          "${Routes.responsiveScaffold}/:id",
          child: (_, args) => ResponsiveScaffoldPage(
            id: args.params['id'],
          ),
        ),
        Router(
          "${Routes.masterDetail}/details/:id",
          child: (_, args) => MasterDetailPage(
            id: args.params['id'],
          ),
        ),
        Router(
          "${Routes.masterDetail}/",
          child: (_, args) => MasterDetailPage(),
        ),
        Router(
          "${Routes.customMasterDetail}",
          child: (_, args) => CustomMasterDetailPage(),
        ),
        Router(
          "${Routes.customMasterDetail}/details/:id",
          child: (_, args) => CustomMasterDetailPage(
            id: args.params['id'],
          ),
        ),
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();
}
