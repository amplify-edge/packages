import 'package:flutter/material.dart';
import 'package:mod_main/modules/campaign/view_model/campaign_view_model.dart';
import 'package:mod_main/modules/campaign/views/campaign_detail_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class CampaignView extends StatelessWidget {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: CampaignViewModel(),
      builder: (context, CampaignViewModel model, child) {
        return Scaffold(
          body: ResponsiveListScaffold.builder(
            scaffoldKey: _scaffoldKey,
            detailBuilder: (context, int index, tablet) {
              return DetailsScreen(
                body: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text("Campaign Details"),
                      automaticallyImplyLeading: !tablet,
                    ),
                    body: CampaignDetailView(campaign: model.campaigns[index])),
              );
            },
            nullItems: Center(child: CircularProgressIndicator()),
            emptyItems: Center(child: Text("No Campaigns")),
            itemCount: 1,
            slivers: <Widget>[
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverAppBar(
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
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  ListTile(
                    leading: Card(
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).cardColor,
                        child: Icon(
                          Icons.list,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    title: Text(
                      "My Campaigns",
                      style:  Theme.of(context).textTheme.title
                         
                    ),
                  ),
                  const Divider()
                ]),
              ),
            ],
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(model.campaigns[index].logoUrl),
                ),
                title: Text(model.campaigns[index].campaignName),
              );
            },
          ),
        );
      },
    );
  }
}
