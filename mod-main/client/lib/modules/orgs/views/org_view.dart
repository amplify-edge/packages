import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mod_main/modules/orgs/view_model/org_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:mod_main/core/core.dart';

import 'org_detail_view.dart';

class OrgView extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: OrgViewModel(),
      builder: (context, OrgViewModel model, child) {
        return Scaffold(
          body: ResponsiveListScaffold.builder(
            scaffoldKey: _scaffoldKey,
            detailBuilder: (context, int index, tablet) {
              return DetailsScreen(
                body: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text(model.orgs[index].campaignName),
                      automaticallyImplyLeading: !tablet,
                    ),
                    body: OrgDetailView(org: model.orgs[index])),
              );
            },
            nullItems: Center(child: CircularProgressIndicator()),
            emptyItems: Center(child: Text(ModMainLocalizations.of(context).translate('noCampaigns'))),
            itemCount: model.orgs.length,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverFloatingBar(
                  elevation: 1.0,
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: TextField(
                    decoration:
                        InputDecoration.collapsed(hintText: ModMainLocalizations.of(context).translate('searchCampaigns')),
                  ),
                ),
              ),
            
            ],
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(model.orgs[index].logoUrl),
                ),
                title: Text(model.orgs[index].campaignName),
              );
            },
          ),
        );
      },
    );
  }
}
