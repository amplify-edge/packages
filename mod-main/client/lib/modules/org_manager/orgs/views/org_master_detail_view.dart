import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_detail_page_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/data_pane/data_pane.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/filter_pane.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:sys_core/sys_core.dart';

class OrgMasterDetailView extends StatelessWidget {
  final int id;
  final List<String> orgs = const [
    "London Tax Strike 1",
    "London Tax Strike 2",
    "London Tax Strike 3"
  ];

  OrgMasterDetailView({Key key, this.id = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetCourageMasterDetail<String>(
      id: id,
      routeWithIdPlaceholder: Modular.get<Paths>().org,
      detailsBuilder: _getDetailsView,
      labelBuilder: (item) => item,
      items: orgs,
      enableSearchBar: true,
    );
  }

  Widget _getDetailsView(BuildContext context, int detailsId) {
    return ViewModelProvider.withConsumer(
      viewModel: OrgsViewModel(),
      builder: (context, OrgsViewModel model, child) => ResponsiveBuilder(
        builder: (context, sizingInfo) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              // iconTheme: Theme.of(context).iconTheme,
              automaticallyImplyLeading:
                  (sizingInfo.screenSize.width > 1100) ? false : true,
              title: Text(orgs[detailsId]),
              // this the mock data
              actions: <Widget>[
                IconButton(
                    tooltip: "Copy Link",
                    icon: Icon(Icons.link),
                    onPressed: () async {
                      String link =
                          "${Modular.get<EnvConfig>().url}/${Modular.get<Paths>().org.replaceFirst("/", "").replaceAll(":id", "${detailsId}")}";
                      // ${Modular.get<Paths>().org.replaceAll(":id", "$index")
                      print(Modular.get<Paths>().baseRoute);
                      await Clipboard.setData(new ClipboardData(text: link));
                      print(link);
                      print(Modular.get<Paths>()
                          .org
                          .replaceFirst("/", "")
                          .replaceAll(":id", "1"));
                    })
              ],
            ),
            drawer: (sizingInfo.screenSize.width > 1100)
                ? null
                : Drawer(child: FilterPane(sizingInfo: sizingInfo)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (sizingInfo.screenSize.width <= 768)
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          return Modular.to.pop(false);
                        },
                      )
                    : Offstage(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      (sizingInfo.screenSize.width > 1100)
                          ? FilterPane(sizingInfo: sizingInfo)
                          : Offstage(),
                      SizedBox(width: 16),
                      Expanded(
                          child: DataPane(
                        sizingInfo: sizingInfo,
                        model: model,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
