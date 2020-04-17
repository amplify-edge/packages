import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_master_page_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'org_detail_page.dart';
import 'org_manager_detail_view.dart';

class OrgMasterPage extends StatelessWidget {
  final String orgID;

  const OrgMasterPage({Key key, this.orgID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: OrgMasterPageViewModel(),
      builder: (context, model, child){
        return  Scaffold(
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
                        decoration: InputDecoration.collapsed(
                            hintText: 'Search Campaigns'),
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
            selected: model.orgs[index] == orgID, /// Later it can be like [model.orgs(index).id]
            onTap: () {
              /// select org here [await model.selectOrg(model.orgs[index])]
              /// and then pass selected org id .i.e. [model.selectedOrg.orgId]
              
              Modular.to.pushNamed(Modular.get<Paths>().org.replaceAll(":id", "${model.orgs[index]}")); /// Later u can pass org id [model.orgs(index).id]
              
              
              // Navigator.of(context).push(MaterialPageRoute(builder: (context){
              //   return OrgManagerDetailView(
              //     masterWidget: OrgMasterPage(orgID: index,),
              //     detailWidget: OrgDetailPage(orgID: (index+1).toString(),),
              //   );
              // },
              // settings: RouteSettings(
              //   name : Modular.get<Paths>().org.replaceAll(":id", "orgDetail?id=${index+1}")
              // )
              // ),
              
              // );
           
            },
          );
        },
        childCount: model.orgs.length,
      ),
    );
  }

}
