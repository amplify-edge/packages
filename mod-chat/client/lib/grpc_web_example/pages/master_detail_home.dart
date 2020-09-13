import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_chat/core/core.dart';
import 'package:mod_chat/core/mocks/orgs_mocks.dart';
import 'package:mod_chat/core/routes/paths.dart';
import 'package:mod_chat/grpc_web_example/pages/home.dart';
import 'package:sys_core/sys_core.dart';

class MasterDetailHome extends StatelessWidget {
  final int id;

  const MasterDetailHome({Key key, this.id = -1}) : super(key: key);

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
        detailsBuilder: (context, detailsId, isFullScreen) => HomePage(),
        noItemsAvailable: Center(
          child: Text(
            ModChatLocalizations.of(context).translate('noCampaigns'),
          ),
        ),
        noItemsSelected: Center(
            child: Text(
                ModChatLocalizations.of(context).translate('noItemsSelected'))),
        disableBackButtonOnNoItemSelected: false,
        masterAppBarTitle:
            Text(ModChatLocalizations.of(context).translate('selectCampaign')),
      ),
    );
  }
}
