


import 'package:flutter/material.dart';
import 'package:mod_main/modules/splash/view_model/splash_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      onModelReady: (model) => model.handleStartUpLogic(),
      viewModel: SplashViewModel(),
      builder: (context, SplashViewModel model, child) =>
    Scaffold(
      body:Center(child: Text("Splash View"),)
    )
    );
  }
}