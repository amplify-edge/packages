import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_master_page_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sys_core/sys_core.dart';

import 'org_detail_page.dart';
import 'org_manager_detail_view.dart';

class OrgMasterPage extends StatelessWidget {
  final int orgID;

  const OrgMasterPage({Key key, this.orgID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: OrgMasterPageViewModel(),
      builder: (context, model, child) {
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
          ),
        );
      },
    );
  }

  SliverList _buildOrgsList(OrgMasterPageViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, int index) {
          return ListTile(
            title: Text(model.orgs[index]),
            selected: index == orgID,

            /// Later it can be like [model.orgs(index).id]
            onTap: () {
              /// select org here [await model.selectOrg(model.orgs[index])]
              /// and then pass selected org id .i.e. [model.selectedOrg.orgId]
              /// Later u can pass org id [model.orgs(index).id]

              //Modular.to.pushNamed(Modular.get<Paths>()
              //    .org
              //    .replaceAll(":id", "${model.orgs[index]}"));

              /*
                  We are not using flutter Modular for pushing the route here
                  since we need dynamic transitions. For the >tablet view
                  there shouldn't be a transition, since on each selection the
                  view is pushed again (to be able to change the omnibox).

                  for small devices there should be a transition to look normal
               */

              bool withTransition = !isTablet(context);
              var routeSettings = RouteSettings(
                name: Modular.get<Paths>().org.replaceAll(":id", "$index"),
              );
              var detailView = OrgManagerDetailView(
                masterWidget: OrgMasterPage(
                  orgID: index,
                ),
                detailWidget: OrgDetailPage(orgID: index),
              );

              Navigator.of(context).push(
                (withTransition)
                    ? MaterialPageRoute(
                        builder: (context) {
                          return detailView;
                        },
                        settings: routeSettings)
                    : PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            detailView,
                        settings: routeSettings),
              );
              /*            child: (_, args) => OrgManagerDetailView(
                  masterWidget: OrgMasterPage(
                    orgID: args.params['id'],
                  ),
                  detailWidget: OrgDetailPage(
                    orgID: args.params['id'],
                  ),
                ),*/
            },
          );
        },
        childCount: model.orgs.length,
      ),
    );
  }
}
