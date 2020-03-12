

import 'package:flutter/material.dart';
import 'package:maintemplate/modules/startup/view_model/startup_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class StartupView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) =>
           Scaffold(
        body: Center(
          child: Text("Sign In")
        ),
      ),
    );
  
  }
}