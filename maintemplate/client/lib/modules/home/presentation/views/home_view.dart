import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context).tabhome()));
  }
}
