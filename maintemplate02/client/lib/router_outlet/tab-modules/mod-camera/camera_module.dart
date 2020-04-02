

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_module.dart';
import 'camera_view.dart';

class CameraModule extends ChildModule{
  @override
  List<Bind> get binds => [];


  @override
  List<Router> get routers => [
     Router("/", child: (_, args) => CameraView()),
  ];

   static Inject get to => Inject<CameraModule>.of();

}

 