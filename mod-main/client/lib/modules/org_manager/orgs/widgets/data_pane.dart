

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DataPane extends StatelessWidget {
  final SizingInformation sizingInfo;

  const DataPane({Key key, this.sizingInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _dataPane(sizingInfo);
  }

  
  Widget _dataPane(SizingInformation sizingInfo) {
    return Container(
      // width: sizingInfo.localWidgetSize.width*0.7,
      child: Column(mainAxisSize: MainAxisSize.min, children: [Text("data")]),
    );
  }
}