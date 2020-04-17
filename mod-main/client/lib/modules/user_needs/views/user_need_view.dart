import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_main/core/shared_services/widget_service.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:mod_main/modules/user_needs/data/user_need_model.dart';
import 'package:mod_main/modules/user_needs/view_model/userneed_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class UserNeedsView extends StatelessWidget {
  final String orgID;

  UserNeedsView({Key key, this.orgID}) : super(key: key);

  List<Widget> buildWidgetList(UserNeedsViewModel model,
      List<List<UserNeed>> userNeedsByGroup, SizedBox spacer) {

    int questionCount = 1;
    List<Widget> _dynamicFormWidgets = [];

    userNeedsByGroup.forEach((userNeedGroup) {
      if (userNeedGroup.length > 1) {
        // Drop down list for multiple items

        List<DropdownMenuItem<String>> dropdownItems =
            userNeedGroup.map((userNeed) {
          return new DropdownMenuItem(
            child: Text(userNeed.description),
            value: userNeed.id,
          );
        }).toList();

        _dynamicFormWidgets.add(Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
            child: DropdownButton(
              hint: Text((questionCount++).toString() + ". " + 'Please Select One'),
              items: dropdownItems,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              isExpanded: true,
              
              onChanged: ((String newValue) {
                print(newValue);
                
              }),
            )));
      } else if (userNeedGroup.first.isTextBox == "yes") {
        // If there is only 1 and it's a textbox

      } else {
        // If there is only 1 and it is NOT a textbox

        UserNeed _userNeed = userNeedGroup.first;

        _dynamicFormWidgets.add(CheckboxListTile(
          title: Text((questionCount++).toString() + '. ' + _userNeed.description),
          value: model.value[_userNeed.id] ?? false,
          onChanged: (bool value) {
            model.selectNeed(_userNeed.id, value);
          },
          //secondary: const Icon(FontAwesomeIcons.peopleCarry),
        ));
      }

      // Add the spacer
      _dynamicFormWidgets.add(spacer);
    });

    return _dynamicFormWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: UserNeedsViewModel(),
      onModelReady: (UserNeedsViewModel model) {
        model.initializeData(orgID);
        //this.buildWidgetList(model, model.userNeedsByGroup, const SizedBox(height: 8.0));
      },
      builder: (context, UserNeedsViewModel model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Your Needs"),
        ),
        body: (model.buzy)
            ? Center(child: Offstage())
            : ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(model.org.logoUrl),
                        ),
                        title: Text(
                          model.org.campaignName,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          model.org.goal,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ListTile(
                    title: Text(
                      'Please choose as many supports or needs you need satisfied to join the action.',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  //...this._dynamicFormWidgets,
                  ...this.buildWidgetList(model, model.userNeedsByGroup,
                      const SizedBox(height: 8.0)),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      initialValue: model.value["9"],
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'I need something else...',
                        alignLabelWithHint: true,
                        hintText: 'I need something else...',
                        fillColor:
                            Theme.of(context).inputDecorationTheme.fillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onSaved: (String value) {
                        model.selectNeed("9", value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          model.navigateNext();
                        },
                        child: Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
