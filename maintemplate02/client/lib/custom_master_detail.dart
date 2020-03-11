import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/app_module.dart';

class CustomMasterDetailPage extends StatefulWidget {
  final String id;

  const CustomMasterDetailPage({Key key, this.id}) : super(key: key);

  @override
  _CustomMasterDetailPageState createState() => _CustomMasterDetailPageState();
}

class _CustomMasterDetailPageState extends State<CustomMasterDetailPage> {
  final tabletBreakpoint = 720.0;

  var _items = Iterable.generate(20).toList();
  var _item;

  var route;

  @override
  void initState() {
    super.initState();
    if (widget.id != null)
      _item =
          _items.firstWhere((element) => element == int.tryParse(widget.id));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(CustomMasterDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      print("neue id im widget");
    }
  }

  openDetailsView() {
    if (widget.id != null && int.tryParse(widget.id) == _item) {
      Modular.to.push(
        MaterialPageRoute(
          builder: (context) => DetailsPane(
            widget: getDetailsPane(),
          ),
        ),
      );
    } else {
      Modular.to.popAndPushNamed(
          Routes.customMasterDetail + "/details/" + _item.toString());
    }
  }

  bool hasRouteChanged() {
    if (route == null /*|| route != Modular.actualRoute*/) {
      route = Modular.actualRoute;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print("modular args, data");
    print(Modular.args.params);
    print(Modular.args.data);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= tabletBreakpoint) {
          //tablet
          return Scaffold(
            body: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(flex: 1, child: getMasterPane()),
                Flexible(
                  flex: 1,
                  child: getDetailsPane(),
                )
              ],
            ),
          );
        } else {
          //mobile
          if (hasRouteChanged()) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              openDetailsView();
            });
          }
          return getMasterPane(isMobile: true);
        }
      },
    );
  }

  getMasterPane({bool isMobile = false}) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          ..._items.map(
            (e) => Container(
              color: (e == _item) ? Colors.red : Colors.white,
              child: ListTile(
                  leading: Text(
                    e.toString(),
                  ),
                  onTap: () {
                    setState(() {
                      _item = e;
                    });
                    if (isMobile) {
                      openDetailsView();
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  getDetailsPane() {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Text(
            (_item == null) ? "no item selected" : _item.toString(),
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DetailsPane extends StatelessWidget {
  final Widget widget;

  const DetailsPane({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
