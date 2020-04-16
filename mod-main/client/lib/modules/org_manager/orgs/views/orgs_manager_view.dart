import 'package:data_tables/data_tables.dart';
import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/core/package/master_detail_utils.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view_desktop.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrgManagerView extends StatefulWidget {
  final String orgID;

  OrgManagerView({Key key, this.orgID}) : super(key: key);

  @override
  _OrgManagerViewState createState() => _OrgManagerViewState();
}

class _OrgManagerViewState extends State<OrgManagerView> {
  String _selectedIndex;
 // bool _routeExists = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.orgID;
    
     Future((){
       Navigator.of(context).push(DetailRoute(
                    builder: (context) {
                      return OrgDashboardDesktopView(index: _selectedIndex,);
                    },
                    settings: RouteSettings(
                      name : ModalRoute.of(context).settings.name
                    )
                  ));
    });
  }

  // void _autoPushRoute(context){
  //   print("_autoPushRoute");
  //   if(_routeExists == false){
  //      if(isTablet(context) == true){
  //      Future((){
  //      Navigator.of(context).push(DetailRoute(
  //                   builder: (context) {
  //                     return OrgDashboardDesktopView();
  //                   },
  //                   settings: RouteSettings(
  //                     name : ModalRoute.of(context).settings.name
  //                   )
  //                 ));
  //       setState(() {
  //           _routeExists  = true;
  //       });
  //   });
  //   }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(ModalRoute.of(context).settings.name);
    //_autoPushRoute(context);

    return 
           ViewModelProvider.withConsumer(
        viewModel: OrgsViewModel(),
        builder: (context, OrgsViewModel model, child) { 
          
          return Scaffold(
            body: MasterDetailContainer(
          masterPage: Scaffold(
            body:  CustomScrollView(
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
          _buildOrgsList(model)
        ],
      ),
          ),
        ));
        }
    );
  }

   SliverList _buildOrgsList(OrgsViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          index = index + 1;
          return ListTile(
            title: Text("London Tax Strike $index"),
            selected: _selectedIndex == index.toString(),
            onTap: () {
              /// select org here [await model.selectOrg(model.orgs[index])]
              /// and then pass selected org id .i.e. [model.selectedOrg.orgId]
              setState(() {
                      _selectedIndex = index.toString();
                    });

                    Navigator.of(context).push(DetailRoute(
                        builder: (context) {
                          return OrgDashboardDesktopView(index : index.toString());
                        },
                        settings: RouteSettings(
                            name: Modular.get<Paths>()
                                .org
                                .replaceAll(':id', "$index"))),);
            },
          );
        },
        childCount: 5,
      ),
    );
  }

}

// class OrgManagerView extends StatelessWidget {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     print(MediaQuery.of(context).size.width);
//     return
//     ViewModelProvider.withConsumer(
//       viewModel: OrgsViewModel(),
//       builder: (context,OrgsViewModel model, child) => Scaffold(
//         body: ResponsiveBuilder(
//           builder: (context, sizingInfo){
//             if(sizingInfo.screenSize.width >= 720){
//               return OrgManagerViewDesktop(model: model,);
//             }

//              return OrgManagerViewMobile(model:model);
//           },
//         )
//       ),
//     );
//   }
// }

// class OrgManagerView extends StatelessWidget {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     print(MediaQuery.of(context).size.width);
//     return
//     ViewModelProvider.withConsumer(
//       viewModel: OrgsViewModel(),
//       builder: (context,OrgsViewModel model, child) => Scaffold(
//         body: ResponsiveListScaffold.builder(
//           scaffoldKey: _scaffoldKey,
//           detailBuilder: (context, int index, tablet) {
//             print("notified");
//             return DetailsScreen(
//               body: Scaffold(
//                   appBar: AppBar(
//                     elevation: 0.0,
//                     centerTitle: true,
//                     title: Text("London Tax Strike"),
//                     automaticallyImplyLeading: !tablet,
//                   ),
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
//       ),
//     );
//   }
// }
