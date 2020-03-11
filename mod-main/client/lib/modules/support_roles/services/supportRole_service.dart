import '../data/supportRole_model.dart';

class SupportRoleService{

  List<SupportRole> _supportRoles = mockSupportRoles;

  List<SupportRole> getSupportRoles(){
    return _supportRoles;
  }

  SupportRole getSupportRoleById(String id){
    for(var role in _supportRoles){
      if(role.id == id){
        return role;
      }
    }
  }
}