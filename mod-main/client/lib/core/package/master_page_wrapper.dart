import 'package:flutter/material.dart';
import 'package:sys_core/syscore.dart';


class MasterPageWrapper extends StatelessWidget {
  final Widget masterPage;

  const MasterPageWrapper({Key key, this.masterPage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
