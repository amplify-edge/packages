import 'package:flutter/material.dart';
import 'package:sys_core/sys_core.dart';

class GetCourageMasterDetail extends StatefulWidget {
  /// [routeWithIdPlaceholder] is the actual route where the
  /// master-detail-view is located at e.g. /myneeds/orgs/:id
  final String routeWithIdPlaceholder;

  /// [id] is the id parsed from the route, can be null
  final int id;

  /// [detailsBuilder] is used to build the details view
  ///[context] is the BuildContext
  ///[detailsId] is the actual selected id
  final Widget Function(BuildContext context, int detailsId) detailsBuilder;

  /// [masterBuilder] is used to build the master view
  ///[context] is the BuildContext
  ///[detailsId] is the actual selected id
  ///[onItemClicked] should fire with an id when an item was clicked
  final Widget Function(
          BuildContext context, int detailsId, void Function(int) onItemClicked)
      masterBuilder;

  /// [noItemsSelected] is the place holder widget for the details view if
  /// nothing was selected
  final Widget noItemsSelected;

  const GetCourageMasterDetail(
      {Key key,
      @required this.masterBuilder,
      @required this.detailsBuilder,
      @required this.routeWithIdPlaceholder,
      this.noItemsSelected,
      this.id = -1})
      : super(key: key);

  @override
  _GetCourageMasterDetailState createState() => _GetCourageMasterDetailState();
}

class _GetCourageMasterDetailState extends State<GetCourageMasterDetail> {
  @override
  Widget build(BuildContext context) {
    bool isMobilePhone = !isTablet(context);
    bool isItemSelected = widget.id >= 0;
    bool showMaster = isMobilePhone && !isItemSelected || !isMobilePhone;
    bool showDetails = isMobilePhone && isItemSelected || !isMobilePhone;

    return Material(
      child: Row(
        children: <Widget>[
          if (showMaster)
            (isMobilePhone) // take the whole width
                ? Expanded(
                    child: widget.masterBuilder(
                        context, widget.id, _pushDetailsRoute),
                  )
                : SizedBox( // fix width size for tablet or desktop
                    width: kTabletMasterContainerWidth,
                    child: widget.masterBuilder(
                        context, widget.id, _pushDetailsRoute),
                  ),
          if (showDetails)
            (isItemSelected)
                ? Expanded(
                    child: widget.detailsBuilder(context, widget.id),
                  )
                : Expanded(
                    child: widget.noItemsSelected ??
                        Center(child: Text("No items selected.")))
        ],
      ),
    );
  }

  _pushDetailsRoute(int newId) {
    print(
        "_pushDetailsRoute newId: $newId, routeWithIdPlaceholder: ${widget.routeWithIdPlaceholder}");
    bool withTransition = !isTablet(context);
    var routeSettings = RouteSettings(
      name: widget.routeWithIdPlaceholder.replaceAll(":id", "$newId"),
    );
    var newMasterDetailView = GetCourageMasterDetail(
      masterBuilder: widget.masterBuilder,
      detailsBuilder: widget.detailsBuilder,
      id: newId,
      routeWithIdPlaceholder: widget.routeWithIdPlaceholder,
    );

    /*
      We are not using flutter Modular for pushing the route here
      since we need dynamic transitions. For the >tablet view
      there shouldn't be a transition, since on each selection the
      view is pushed again (to be able to change the omnibox).

      for small devices there should be a transition to look normal
    */
    Navigator.of(context).push(
      (withTransition)
          ? MaterialPageRoute(
              builder: (context) {
                return newMasterDetailView;
              },
              settings: routeSettings)
          : PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  newMasterDetailView,
              settings: routeSettings),
    );
  }
}
