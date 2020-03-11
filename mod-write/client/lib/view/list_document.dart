import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_write/stub_data.dart';
import 'package:mod_write/view/src/full_page.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class DocumentList extends StatefulWidget {
  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  Document _document;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _listDocument = StubData.documents;

    return ResponsiveListScaffold.builder(
      scaffoldKey: _scaffoldKey,
      detailBuilder: (BuildContext context, int index, bool tablet) {
        return DetailsScreen(
          body: new FullPageEditorScreen(
            key: ValueKey(_listDocument[index].id),
            id: _listDocument[index].id,
          ),
        );
      },
      nullItems: Center(child: CircularProgressIndicator()),
      emptyItems: Center(
        child: ListTile(
          title: Text("No Items Found"),
        ),
      ),
      itemCount: _listDocument?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(leading: Text(_listDocument[index].name));
      },
    );
  }
}
