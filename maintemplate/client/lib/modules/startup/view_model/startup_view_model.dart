

import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';

class StartUpViewModel extends BaseModel{

  bool _isLoggedIn = false;


  void handleStartUpLogic(){
    if(_isLoggedIn == true){
      Modular.to.pushNamed(Paths.home);
    }else{
      Modular.to.pushNamed(Paths.login);
    }

  }



}