


import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';
// import 'package:mod_write/mod_write.dart';

import 'views/writer_view.dart';

class WriterModule extends ChildModule{
  @override
  List<Bind> get binds => [

  ];

  @override
  List<Router> get routers => [
    Router(Paths.writer, child: (context, args) => WriterView())
  ];

  static Inject get to => Inject<WriterModule>.of();

}