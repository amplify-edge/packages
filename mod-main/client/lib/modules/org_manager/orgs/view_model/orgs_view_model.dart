

import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/data/org_model.dart';

class OrgsViewModel extends BaseModel{
  List<Org> _orgs = mockOrgs;
  int _rowsPerPage = 10;
  int _firstRowIndex = 0;
  int _sortColumnIndex;
  bool _sortAscending = true;


  List<Org> get orgs => _orgs;
  int get rowsPerPage => _rowsPerPage;
  int get firstRowIndex => _firstRowIndex;
   int get sortColumnIndex => _sortColumnIndex;
  bool get sortAscending => _sortAscending;


  
  void handleNextPage() async{
    _firstRowIndex += _rowsPerPage;
    notifyListeners();
  }

  void handlePrevPage(){
    _firstRowIndex -= _rowsPerPage;
    notifyListeners();
  }
}