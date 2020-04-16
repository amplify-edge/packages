import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';



class OrgManagerViewDesktop extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final OrgsViewModel model;

  OrgManagerViewDesktop({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return
     Scaffold(
        body: ResponsiveListScaffold.builder(
          tabletBreakpoint: 600,
          scaffoldKey: _scaffoldKey,
          detailBuilder: (context, int index, tablet) {
            index = index + 1;
            print("notified");
            return DetailsScreen(
              body: Scaffold(
                  body: OrgsDashboardView(model: model)),
            );
          },
          nullItems: Center(child: CircularProgressIndicator()),
          emptyItems: Center(child: Text("No Campaigns")),
          itemCount: 1,
          slivers: <Widget>[
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverFloatingBar(
                elevation: 1.0,
                floating: true,
                pinned: true,
                automaticallyImplyLeading: false,
                title: TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: 'Search Campaigns'),
                ),
              ),
            ),
          ],
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // leading: CircleAvatar(
              //   radius: 20,
              //   backgroundImage: NetworkImage(model.orgs[index].logoUrl),
              // ),
              title: Text("London Tax Strike"),
            );
          },
        ),
      );

  }
}


// class OrgManagerViewDesktop extends StatelessWidget {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final OrgsViewModel model;

//   OrgManagerViewDesktop({Key key, this.model}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print(MediaQuery.of(context).size.width);
//     return
//      Scaffold(
//         body: ResponsiveListScaffold.builder(
//           tabletBreakpoint: 600,
//           scaffoldKey: _scaffoldKey,
//           detailBuilder: (context, int index, tablet) {
//             index = index + 1;
//             print("notified");
//             return DetailsScreen(
//               body: Scaffold(
//                   body: OrgsDashboardView(model: model)),
//             );
//           },
//           nullItems: Center(child: CircularProgressIndicator()),
//           emptyItems: Center(child: Text("No Campaigns")),
//           itemCount: 1,
//           slivers: <Widget>[
//             const SliverPadding(
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               sliver: SliverFloatingBar(
//                 elevation: 1.0,
//                 floating: true,
//                 pinned: true,
//                 automaticallyImplyLeading: false,
//                 title: TextField(
//                   decoration:
//                       InputDecoration.collapsed(hintText: 'Search Campaigns'),
//                 ),
//               ),
//             ),
//           ],
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               // leading: CircleAvatar(
//               //   radius: 20,
//               //   backgroundImage: NetworkImage(model.orgs[index].logoUrl),
//               // ),
//               title: Text("London Tax Strike"),
//             );
//           },
//         ),
//       );

//   }
// }
