

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';

class SplashViewModel extends BaseModel{


  void handleStartUpLogic() {
    Future.delayed(Duration(seconds: 5), (){
      Modular.to.pushReplacementNamed(Paths.userInfo);
    });
  }
}