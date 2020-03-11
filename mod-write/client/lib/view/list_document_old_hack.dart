import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_write/stub_data.dart';
import 'package:mod_write/view/src/full_page.dart';


class DocumentListOld extends StatefulWidget {
  @override
  _DocumentListOldState createState() => _DocumentListOldState();
}

class _DocumentListOldState extends State<DocumentListOld> {
  Document _document;

  @override
  Widget build(BuildContext context) {
    print("DocumentList");
    var _listDocumentOld = StubData.documents;

    return LayoutBuilder(
      builder: (context, constraints) {
        //tablet
        if (constraints.maxWidth >= 720 && constraints.maxHeight > 400) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: _listDocumentOld.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _document = _listDocumentOld[index];
                              });
                              //MasterDetailScaffold.of(context).detailsPaneNavigator.pushNamed(
                              //    '${ModWriterModule.fullPageRoute}?id=${_document?.id??"1"}');
                            },
                            leading: Text(_listDocumentOld[index].name),
                          );
                        },
                      ),
                    ),
                    (_document != null)
                        ? Expanded(
                            child: FullPageEditorScreen(
                              key: ValueKey(_document.id),
                              id: _document.id,
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          );
        } else
          return ListView.builder(
            itemCount: _listDocumentOld.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _document = _listDocumentOld[index];
                  });
                  //MasterDetailScaffold.of(context).detailsPaneNavigator.pushNamed(
                  //    '${ModWriterModule.fullPageRoute}?id=${_document?.id??"1"}');
                  Modular.to.push(MaterialPageRoute(
                    builder: (context) =>
                        FullPageEditorScreen(id: _document.id),
                  ));
                },
                leading: Text(_listDocumentOld[index].name),
              );
            },
          );
      },
    );

    /*MasterDetailScaffold(

      initialAppBar: null,
      initialRoute: ModWriterModule.baseRoute,
      masterPaneBuilder: (context) {
        return ListView.builder(
          itemCount: _listDocument.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                setState(() {
                  _document = _listDocument[index];
                });
                //MasterDetailScaffold.of(context).detailsPaneNavigator.pushNamed(
                //    '${ModWriterModule.fullPageRoute}?id=${_document?.id??"1"}');
              },
              leading: Text(_listDocument[index].name),
            );
          },
        );
      },
      masterPaneWidth: MediaQuery.of(context).size.width * 0.5,
      twoPanesWidthBreakpoint: 450,
      detailsAppBar: AppBar(),
      detailsPaneBuilder: (context) {
        return FullPageEditorScreen(
          id: _document?.id??"1",
        );
      },
      detailsRoute: ModWriterModule.fullPageRoute,
      onDetailsPaneRouteChanged:
          (String route, Map<String, String> parameters) {
        if (route == ModWriterModule.baseRoute && parameters != null) {
          print("parameters $parameters");
          setState(() {
            _document = StubData.documents.firstWhere(
                (item) => item.id.toString() == parameters['id'],
                orElse: null);
          });
        }
      },
    );

       */
  }
}
