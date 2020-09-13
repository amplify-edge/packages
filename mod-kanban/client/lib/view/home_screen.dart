import 'package:flutter/material.dart';
import 'package:mod_kanban/core/i18n/mod_kanban_localization.dart';

class HomeScreen extends StatefulWidget {
  final bool automaticallyImplyLeading;

  const HomeScreen({Key key, this.automaticallyImplyLeading = false})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cards = ["ToDo", "Completed"];
  List<List<String>> childres = [
    List.generate(150, (index) => "Item $index"),
    ["Done 1", "Done 2"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        title: Text("Kanban"),
      ),
      body: _buildBody(),
    );
  }

  TextEditingController _cardTextController = TextEditingController();
  TextEditingController _taskTextController = TextEditingController();

  _showAddCard() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ModKanbanLocalizations.of(context).translate("addCard"),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: ModKanbanLocalizations.of(context).translate("cardTitle")),
                    controller: _cardTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCard(_cardTextController.text.trim());
                    },
                    child: Text(ModKanbanLocalizations.of(context).translate("addCard")),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCard(String text) {
    cards.add(text);
    childres.add([]);
    _cardTextController.text = "";
    setState(() {});
  }

  _showAddCardTask(int index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ModKanbanLocalizations.of(context).translate("addCardTask"),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: ModKanbanLocalizations.of(context).translate("taskTitle")),
                    controller: _taskTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCardTask(index, _taskTextController.text.trim());
                    },
                    child: Text(ModKanbanLocalizations.of(context)
                        .translate("addTask")),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCardTask(int index, String text) {
    childres[index].insert(0, text);
    _taskTextController.text = "";
    setState(() {});
  }

  _handleReOrder(int oldIndex, int newIndex, int index) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    var item = childres[index].removeAt(oldIndex);
    childres[index].insert(newIndex, item);
    setState(() {});
  }

  _buildBody() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cards.length + 1,
      itemBuilder: (context, index) {
        if (index == cards.length)
          return _buildAddCardWidget(context);
        else
          return _buildCard(context, index);
      },
    );
  }

  Widget _buildAddCardWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              _showAddCard();
            },
            child: Card(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: 300.0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(ModKanbanLocalizations.of(context)
                        .translate("addCard")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardTaskWidget(context, index) {
    return Container(
      key: ValueKey("_buildAddCardTaskWidget"),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          _showAddCardTask(index);
        },
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
            ),
            SizedBox(
              width: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  ModKanbanLocalizations.of(context).translate("addCardTask")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    // return Container(
    //         width: 300.0,
    //   child: ,
    // );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Card(
            child: Container(
              width: 300.0,
              margin: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      cards[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ReorderableListView(
                      key: UniqueKey(),
                      scrollController: ScrollController(),
                      onReorder: (oldIndex, newIndex) =>
                          _handleReOrder(oldIndex, newIndex, index),
                      children: [
                        ...childres[index]
                            .map((e) => _buildCardTask(
                                index, childres[index].indexOf(e)))
                            .toList(),
                      ],
                    ),
                  ),
                  _buildAddCardTaskWidget(context, index),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                print(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                if (data['from'] == index) {
                  return;
                }
                childres[data['from']].remove(data['string']);
                childres[index].add(data['string']);
                print(data);
                setState(() {});
              },
              builder: (context, accept, reject) {
                print("--- > $accept");
                print(reject);
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCardTask(int index, int innerIndex) {
    return Container(
      key: ValueKey(childres[index][innerIndex]),
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).accentColor,
        child: Text(
          childres[index][innerIndex],
          style: TextStyle(
              color: Theme.of(context).accentTextTheme.subtitle1.color),
        ),
      ),
    );
  }
}
