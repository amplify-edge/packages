import 'package:flutter/material.dart';
import 'package:sys_core/sys_core.dart';

class DetailPageWrapper extends StatelessWidget {
  final Widget masterWidget;
  final Widget detailWidget;

  const DetailPageWrapper({Key key, this.masterWidget, this.detailWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: <Widget>[
          (!isTablet(context))
              ? Offstage()
              : Container(
                  width: kTabletMasterContainerWidth,
                  child: masterWidget,
                ),
          Expanded(
            child: detailWidget,
          )
        ],
      ),
    );
  }
}
