

import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child:Text(AppLocalizations.of(context).tabchat()));
  }
}