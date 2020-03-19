import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class OrgManagerView extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
        print(MediaQuery.of(context).size.width);
        return Scaffold(
          body: ResponsiveListScaffold.builder(
        
            scaffoldKey: _scaffoldKey,
            detailBuilder: (context, int index, tablet) {
              return DetailsScreen(
                body: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text("London Tax Strike"),
                      automaticallyImplyLeading: !tablet,
                    ),
                    body: OrgsDashboardView()
                    ),
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
