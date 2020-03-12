import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

import '../view_model/supportRole_view_model.dart';

class SupportRoleView extends StatelessWidget {
  final String orgId;


  SupportRoleView({Key key, this.orgId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (SupportRoleViewModel model) {
        model.fetchOrgById(orgId);
      },
      viewModel: SupportRoleViewModel(),
      builder: (context, SupportRoleViewModel model, child) => Scaffold(
        appBar: AppBar(
          title:Text("Support Roles"),
          centerTitle:true,
        ),
        body:(model.buzy) ?
        Center(child: Offstage()) 
        : Column(children: [
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(model.org.logoUrl),
                ),
                title: Text(
                  model.org.campaignName,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  model.org.goal,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: _buildSupportRolesList(context, model),
          ),
          const SizedBox(height: 16.0),
          ButtonBar(children: [
            RaisedButton(
              onPressed: () {},
              child: Text("Next"),
            )
          ]),
        ]),
      ),
    );
  }

  Widget _buildSupportRolesList(context, SupportRoleViewModel model) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: model.supportRoles.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _supportRole(context, model, index),
        );
      },
    );
  }

  Widget _supportRole(
      BuildContext context, SupportRoleViewModel model, int index) {
    final role = model.supportRoles[index];
    return InkWell(
      onTap: () {},
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: Text(
                    role.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    role.description,
                  ),
                  value: model.values[index],
                  onChanged: (bool value) {
                    model.selectRole(value, index);
                  },
                ),
                const SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    'Minimum hours you can dedicate  : ',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  trailing: Text(
                    '${model.minHours[index]} hr',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Slider(
                      label: model.minHours[index].toString(),
                      divisions: 8,
                      min: 0.0,
                      max: 8,
                      value: model.minHours[index],
                      onChanged: (double value) {
                        model.selectMinHours(value, index);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
