import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';
import 'package:mod_main/modules/org_manager/orgs/view_model/orgs_view_model.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/data_pane/data_pane.dart';
import 'package:mod_main/modules/org_manager/orgs/widgets/filter_pane.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OrgDashboardMobileView extends StatelessWidget {
   final OrgsViewModel model;

  const OrgDashboardMobileView({Key key, this.model}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    print("Mobile ");
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Scaffold(
           appBar: AppBar(
              elevation: 0,
             // iconTheme: Theme.of(context).iconTheme,  
             
              automaticallyImplyLeading: true,
              title: Text("London Tax Strike"),
              actions: <Widget>[
                 IconButton(
                              tooltip: "Copy Link",
                              icon: Icon(Icons.link), onPressed: () async {
                                String link = "${Modular.get<EnvConfig>().url}/${Modular.get<Paths>().org.replaceFirst("/", "").replaceAll(":id", "1")}";
                                // ${Modular.get<Paths>().org.replaceAll(":id", "$index")
                                print(Modular.get<Paths>().baseRoute);
                              await Clipboard.setData(new ClipboardData(text: link));
                              print(link);
                              print(Modular.get<Paths>().org.replaceFirst("/", "").replaceAll(":id", "1"));
                            })
              ],
            ),
          drawer: Drawer(
              child: FilterPane(sizingInfo: sizingInfo)),
          body: Center(child:
             
              DataPane(sizingInfo: sizingInfo, model: model,),
           
          ));
      },
    );
  }
}
