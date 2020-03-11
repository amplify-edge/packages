import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_module.dart';
import 'package:master_detail_scaffold/master_detail_scaffold.dart';

class MasterDetailPage extends StatefulWidget {
  final String id;

  const MasterDetailPage({Key key, this.id}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  var _selectedItem;
  final List _itemList = Iterable.generate(20).toList();

  @override
  Widget build(BuildContext context) {
    print(Modular.args.params);
    print(Modular.args.data);
    print(Modular.actualRoute);
    return MasterDetailScaffold(
      onDetailsPaneRouteChanged:
          (String route, Map<String, String> parameters) {
        setState(() {
          if (route == Routes.masterDetail + "/details/") {
            print("parmaters $parameters onDetailsPaneRouteChanged");
            //_selectedItem = _itemList,
            //    orElse: null);

            return;
          }
          _selectedItem = null;
        });
      },
      twoPanesWidthBreakpoint: 600,
      initialRoute: Routes.masterDetail,
      detailsRoute: Routes.masterDetail + "/details",
      initialAppBar: AppBar(
        title: Text('Master-detail Flow Demo'),
      ),
      masterPaneWidth: 400,
      masterPaneBuilder: (BuildContext context) => ListView(
        children: <Widget>[
          ..._itemList.map(
            (e) => ListTile(
              leading: Text(
                e.toString(),
              ),
              selected: (_selectedItem == e),
              onTap: () {
                MasterDetailScaffold.of(context)
                    .detailsPaneNavigator
                    .pushNamed(Routes.masterDetail + "/2/detail");
              },
            ),
          ),
        ],
      ),
      detailsPaneBuilder: (BuildContext context) =>
          ItemDetails(item: _selectedItem),
      detailsAppBar: AppBar(
        // the [Builder] widget is needed to ensure that the widget for displaying the title gets rebuilt based on the selected item.
        // Without the [Builder] widget, the title is set to the value that was originally passed through
        title: Builder(
          builder: (context) => Text(_selectedItem),
        ),
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  final int item;

  const ItemDetails({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("item: $item"),
    );
  }
}
