import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_ion/core/mocks/orgs_mocks.dart';
import 'package:mod_ion/core/routes/paths.dart';
import 'package:mod_ion/mod_ion.dart';
import 'package:mod_ion/src/call_sample/call_sample.dart';
import 'package:sys_core/sys_core.dart';

class MasterDetailHome extends StatelessWidget {
  final String ip;
  final int id;

  const MasterDetailHome({Key key, this.id = -1, @required this.ip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetCourageMasterDetail<Org>(
        enableSearchBar: false,
        id: id,
        items: Org.orgsMock,
        labelBuilder: (item) => item.name,
        //imageBuilder: (item) => item.logoUrl,
        routeWithIdPlaceholder: Modular.get<Paths>().masterDetailRoute,
        detailsBuilder: (context, detailsId, isFullScreen) => CallSample(ip: ip),
        noItemsAvailable: Center(
          child: Text(
            ModIonLocalizations.of(context).translate('noCampaigns'),
          ),
        ),
        noItemsSelected: Center(
            child: Text(
                ModIonLocalizations.of(context).translate('noItemsSelected'))),
        disableBackButtonOnNoItemSelected: false,
        masterAppBarTitle:
            Text(ModIonLocalizations.of(context).translate('selectCampaign')),
      ),
    );
  }
}
