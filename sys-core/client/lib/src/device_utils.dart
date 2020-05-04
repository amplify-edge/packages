import 'package:flutter/widgets.dart';

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 768.0;
}
const kTabletMasterContainerWidth = 200.0;

