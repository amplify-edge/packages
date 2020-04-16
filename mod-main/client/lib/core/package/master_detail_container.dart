import 'package:flutter/material.dart';

import 'master_detail_utils.dart';
import 'master_page.dart';

class MasterDetailContainer extends StatelessWidget {
  final Widget masterPage;

  const MasterDetailContainer({Key key, this.masterPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: isTablet(context) ? kTabletMasterContainerWidth : MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: masterPage),
            Expanded(child: Center(child: Text("No item selected."),))
          ],
        ));
  }
}
