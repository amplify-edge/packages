import 'package:flutter/material.dart';
import 'package:mod_main/core/package/detail_page_wrapper.dart';
import 'package:mod_main/core/package/master_detail_utils.dart';



class OrgManagerDetailView extends StatelessWidget {
  final Widget masterWidget;
  final Widget detailWidget;

  const OrgManagerDetailView({Key key, this.masterWidget, this.detailWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DetailPageWrapper(
      masterWidget: masterWidget,
      detailWidget: detailWidget,
    );
  }
}
