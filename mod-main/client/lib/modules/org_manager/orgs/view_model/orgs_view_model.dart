import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/data/org_model.dart';

class OrgsViewModel extends BaseModel {

  // This all is to manage orgs, please change it to match the users data model.
  
  List<Org> _orgs = mockOrgs;
  int _rowsPerPage = 10;
  int _firstRowIndex = 0;
  int _sortColumnIndex;
  bool _sortAscending = true;
  List<bool> _selected = List<bool>.generate(10, (index) => false);
  List<Org> _orgsPerPage = List<Org>.generate(10, (index) => mockOrgs[index]);


  List<Org> get orgs => _orgs;
  List<Org> get orgsPerPage => _orgsPerPage;
  int get rowsPerPage => _rowsPerPage;
  int get firstRowIndex => _firstRowIndex;
  int get sortColumnIndex => _sortColumnIndex;
  bool get sortAscending => _sortAscending;
  List<bool> get selected => _selected;

  void changeSelection(bool value, int index) {
    _selected[index] = value;
    notifyListeners();
  }

  void onSelectAll(bool value) {
    _selected = List<bool>.generate(_orgsPerPage.length, (index) => value);
    notifyListeners();
  }

  void handleNextPage() async {
    if(_firstRowIndex + _rowsPerPage >= mockOrgs.length){
      return;
    }
    _firstRowIndex += _rowsPerPage;
    print("first row index : $_firstRowIndex");
   // await Future.delayed(Duration(seconds: 2));
    _orgsPerPage += List<Org>.generate(
        _rowsPerPage, (index) => mockOrgs[_firstRowIndex + index]);
    _selected += List<bool>.generate(_rowsPerPage, (index) => false);
    print(_orgsPerPage.length);
    notifyListeners();
  }

  void handlePrevPage() async {
    
    print("first row index : $_firstRowIndex");
    int start = _firstRowIndex;
    int end = _firstRowIndex + _rowsPerPage;
    print("Start : $start");
    print("End : $end");
    _orgsPerPage.removeRange(start, end);
    _selected.removeRange(start, end);
  //  await Future.delayed(Duration(seconds: 2));
    _firstRowIndex -= _rowsPerPage;
    notifyListeners();
  }

  void sort<T>(Comparable<T> getField(Org d), int columnIndex, bool ascending) {
    _orgs.sort((Org a, Org b) {
      if (!ascending) {
        final Org c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });

    _sortColumnIndex = columnIndex;
    _sortAscending = ascending;

    notifyListeners();
  }
}
