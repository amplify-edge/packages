
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_module.dart';
import 'gallery_view.dart';


class GalleryModule extends ChildModule {
  @override
  List<Bind> get binds => [];

   @override
  List<Router> get routers => [
     Router("/", child: (_, args) => GalleryView()),
  ];

   static Inject get to => Inject<GalleryModule>.of();


}

 