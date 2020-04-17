import 'package:flutter/material.dart';

import 'master_detail_utils.dart';

class DetailPageWrapper extends StatelessWidget {
  final Widget masterWidget;
  final Widget detailWidget;

  const DetailPageWrapper({Key key, this.masterWidget, this.detailWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        (!isTablet(context)) ? Offstage() :
        Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
           width: kTabletMasterContainerWidth,
           child: masterWidget,)),
        Positioned(
            left: isTablet(context) ? kTabletMasterContainerWidth : 0,
            top: 0,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: isTablet(context)
                    ? MediaQuery.of(context).size.width -
                        kTabletMasterContainerWidth
                    : MediaQuery.of(context).size.width,
                child: detailWidget))
      ],
    );
  }
}
