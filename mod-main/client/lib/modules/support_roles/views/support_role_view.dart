import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:mod_main/modules/support_roles/data/support_role_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:mod_main/core/shared_services/dynamic_widget_service.dart';
import 'package:mod_main/core/core.dart';

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
          title:
              Text(ModMainLocalizations.of(context).translate('supportRoles')),
          centerTitle: true,
        ),
        body: (model.buzy)
            ? Center(child: Offstage())
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
                    onPressed: () {
                      model.save();
                      Modular.to.pushNamed('/account/signup');
                    },
                    child: Text(
                        ModMainLocalizations.of(context).translate('next')),
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
        SupportRole sp = model.supportRoles[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DynamicSlider(
            title: sp.name,
            question: sp.description,
            current: model.minHours[sp.id] ?? 0.0,
            min: 0.0,
            max: 8.0,
            callbackInjection: (String value) {
              model.selectMinHours(double.tryParse(value) ?? 0.0, sp.id);
            },
          ),
        );
      },
    );
  }
}
