import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_kanban/core/i18n/mod_kanban_localization.dart';
import 'package:mod_kanban/core/mocks/orgs_mocks.dart';
import 'package:mod_kanban/core/routes/paths.dart';
import 'package:mod_kanban/view/home_screen.dart';
import 'package:sys_core/sys_core.dart';

class MasterDetailHome extends StatelessWidget {
  final int id;

  const MasterDetailHome({Key key, this.id = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetCourageMasterDetail<Org>(
      id: id,
      routeWithIdPlaceholder: Modular.get<Paths>().masterDetail,
      detailsBuilder: (context, detailsId, isFullScreen) =>
          HomeScreen(),
      items: Org.orgsMock,
      labelBuilder: (item) => item.name,
      noItemsAvailable: Center(
        child: Text(
          KanbanLocalizations.of(context).translate('noCampaigns'),
        ),
      ),
      noItemsSelected: Center(
          child: Text(
              KanbanLocalizations.of(context).translate('noItemsSelected'))),
      disableBackButtonOnNoItemSelected: true,
      masterAppBarTitle:
      Text(KanbanLocalizations.of(context).translate('selectCampaign')),
    );
  }
}
