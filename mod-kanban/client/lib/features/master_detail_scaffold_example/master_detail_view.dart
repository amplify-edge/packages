import 'package:flutter/material.dart';
import 'package:modkanban/core/routes/router.dart';
import 'package:modkanban/features/master_detail_scaffold_example/data/mock_item.dart';
import 'package:master_detail_scaffold/master_detail_scaffold.dart';
import 'package:provider/provider.dart';

class MasterDetailView extends StatefulWidget {
  @override
  _MasterDetailViewState createState() => _MasterDetailViewState();
}

class _MasterDetailViewState extends State<MasterDetailView> {
  MockItem _selectedItem;
  @override
  Widget build(BuildContext context) {
    return MasterDetailScaffold(
        masterPaneBuilder: (context) {
          return Consumer<List<MockItem>>(builder: (_, model, __) {
            return ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                final item = model[index];
                return ListTile(
                  onTap: () {
                    MasterDetailScaffold.of(context).detailsPaneNavigator.pushNamed(
                        '${RouteNames.ItemDetails}?id=${item.id}');
                  },
                  leading: Text(mockItemsList[index].id.toString()),
                );
              },
            );
          });
        },
        masterPaneWidth: MediaQuery.of(context).size.width * 0.5,
        detailsAppBar: AppBar(title: Text("Details")),
        detailsPaneBuilder: (context) {
          return Center(
            child: Text(_selectedItem.description),
          );
        },
        initialAppBar: AppBar(title: Text("AppBar")),
        twoPanesWidthBreakpoint: 450,
        initialRoute: RouteNames.Home,
        detailsRoute: RouteNames.ItemDetails,
        onDetailsPaneRouteChanged:
            (String route, Map<String, String> parameters) {
          setState(() {
            if (route == RouteNames.ItemDetails) {
              _selectedItem = mockItemsList.firstWhere(
                  (item) => item.id.toString() == parameters['id'],
                  orElse: null);
            }
          });
        });
  }
}
