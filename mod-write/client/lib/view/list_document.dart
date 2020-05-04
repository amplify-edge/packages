import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_write/stub_data.dart';
import 'package:mod_write/view/src/full_page.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:sys_core/sys_core.dart';
import 'package:mod_write/core/routes/paths.dart';

class DocumentList extends StatefulWidget {
  final int id;

  const DocumentList({Key key, this.id = -1}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  var _listDocument = StubData.documents;

  @override
  Widget build(BuildContext context) {
    return GetCourageMasterDetail(
      id: widget.id,
      routeWithIdPlaceholder: Modular
          .get<Paths>()
          .detail,
      detailsBuilder: (context, detailsId) =>
          FullPageEditorScreen(key: ValueKey(detailsId),
              id: detailsId),
      masterBuilder: _getMasterView,
    );
  }


  Widget _getMasterView(BuildContext context, int detailsId,
      void Function(int) onItemClicked) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context, int index) {
            return ListTile(
              title: Text(_listDocument[index].name),
              selected: index == detailsId,
              onTap: () {
                print("onItemClicked: $index");
                onItemClicked(index);
              },
            );
          }, childCount: _listDocument.length),
        ),
      ],
    );
  }
}
