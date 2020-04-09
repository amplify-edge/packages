// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:maintemplate02/custom_master_detail.dart';
import 'package:maintemplate02/home_page.dart';
import 'package:maintemplate02/login_page.dart';
import 'package:maintemplate02/master_detail.dart';
import 'package:maintemplate02/official_nav.dart';
import 'package:maintemplate02/responsive_scaffold.dart';
import 'package:maintemplate02/router_outlet/tab-modules/tab_module.dart';
import 'router_outlet/nav_rail.dart';
import 'router_outlet/tab-modules/mod-camera/camera_module.dart';
import 'router_outlet/tab-modules/mod-folder/folder_module.dart';
import 'router_outlet/tab-modules/mod-gallery/gallery_module.dart';

class Routes {
  static final String home = "/";
  static final String login = "/login";
  static final String responsiveScaffold = "/responsiveScaffold";
  static final String masterDetail = "/masterDetail";
  static final String customMasterDetail = "/customMasterDetail";
  static final String routerOutlet = "/routerOutlet";
  static final String folder = "/folder";
  static final String gallery = "/gallery";
  static final String camera = "/camera";
  static final String officialNav = "/officialNav";
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

        //  Router(
        //   "${Routes.officialNav}",
        //   child: (_, args) => OfficialNavRail(),
        // ),

        Router(Routes.routerOutlet, module: TabsModule()),

      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();
}
