

import 'package:flutter/material.dart';
import 'package:maintemplate/core/core.dart';
import 'package:maintemplate/modules/startup/view_model/startup_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class StartupView extends StatelessWidget {
  bool _login = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) =>
           Scaffold(
        body: CircularProgressIndicator(),
      ),
    );
    // if(_login){
    //   Navigator.of(context).pushNamed(Paths.login);
    // }else{
    //    Navigator.of(context).pushNamed(Paths.home);
    // }
  }
}