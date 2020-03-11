import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class ResponsiveScaffoldPage extends StatefulWidget {
  final String id;

  const ResponsiveScaffoldPage({Key key, this.id}) : super(key: key);

  @override
  _ResponsiveScaffoldPageState createState() => _ResponsiveScaffoldPageState();
}

class _ResponsiveScaffoldPageState extends State<ResponsiveScaffoldPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _items;

  @override
  void initState() {
    _items = List.generate(20, (int index) => "test_$index");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveListScaffold.builder(
      mobileNavigator: Modular.navigatorKey.currentState,
      scaffoldKey: _scaffoldKey,
      detailBuilder: (BuildContext context, int index, bool tablet) {
        final i = _items[index];
        return DetailsScreen(
          body: new ExampleDetailsScreen(
            items: _items,
            row: i,
            tablet: tablet,
            onDelete: () {
              setState(() {
                _items.removeAt(index);
              });
              if (!tablet) Navigator.of(context).pop();
            },
            onChanged: (String value) {
              setState(() {
                _items[index] = value;
              });
            },
          ),
        );
      },
      nullItems: Center(child: CircularProgressIndicator()),
      emptyItems: Center(child: Text("No Items Found")),
      slivers: <Widget>[
        SliverAppBar(
          title: Text("App Bar"),
        ),
      ],
      itemCount: _items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final i = _items[index];
        return ListTile(
          leading: Text(i),
        );
      },
    );
  }
}

class ExampleDetailsScreen extends StatelessWidget {
  const ExampleDetailsScreen({
    Key key,
    @required List<String> items,
    @required this.row,
    @required this.tablet,
    @required this.onDelete,
    @required this.onChanged,
  })  : _items = items,
        super(key: key);

  final List<String> _items;
  final String row;
  final bool tablet;
  final VoidCallback onDelete;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: !tablet,
        title: Text("Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              onChanged(row + " " + DateTime.now().toString());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Item: $row"),
        ),
      ),
    );
  }
}
