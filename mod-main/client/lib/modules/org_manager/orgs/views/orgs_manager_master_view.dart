import 'package:flutter/material.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/views/org_master_page.dart';

class OrgManagerMasterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MasterPageWrapper(
        masterPage: OrgMasterPage(orgID: -1,), // -1 indicates no selected index
      ),
    );
  }
}
