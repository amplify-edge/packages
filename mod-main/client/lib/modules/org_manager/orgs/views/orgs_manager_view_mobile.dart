import 'package:data_tables/data_tables.dart';
import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/views/orgs_dashboard_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class OrgManagerViewMobile extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final OrgsViewModel model;

  OrgManagerViewMobile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
        body: CustomScrollView(
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
    ));
  }

  SliverList _buildOrgsList(OrgsViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          return ListTile(
            title: Text("London Tax Strike"),
            onTap: (){
              /// select org here [await model.selectOrg(model.orgs[index])]
              /// and then pass selected org id .i.e. [model.selectedOrg.orgId]
              Modular.to.pushNamed(Modular.get<Paths>().org.replaceAll(':id', "1"), arguments: model);
            },
          );
        },
        childCount: 1,
      ),
    );
  }

}


class OrgsDetailViewMobile extends StatelessWidget {
  final OrgsViewModel model;
  final String orgID;
  
  const OrgsDetailViewMobile({Key key,this.orgID, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: OrgsViewModel(),
      builder: (context,OrgsViewModel model, child) =>
           Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text("London Tax Strike"),
                      automaticallyImplyLeading: true,
                    ),
                    body: OrgsDashboardView(model: model),),
    );
    
  }
}
