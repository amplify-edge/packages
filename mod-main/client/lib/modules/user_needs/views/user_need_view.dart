import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:mod_main/modules/user_needs/view_model/userneed_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class UserNeedsView extends StatelessWidget {
  final String orgID;

  UserNeedsView({Key key, this.orgID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: UserNeedsViewModel(),
      onModelReady: (UserNeedsViewModel model) {
        model.fetchOrgById(orgID);
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
                      'Please choose up to 3 supports or needs you need satisfied to join the action.',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  CheckboxListTile(
                    title: const Text(
                        '1. I need to know that there will be enough people at the action for the campaign to have a high chance of success'),
                    value: model.value["1"],
                    onChanged: (bool value) {
                      model.selectNeed("1", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.peopleCarry),
                  ),
                  CheckboxListTile(
                    title: const Text(
                        '2. I need to be more confident that I will be able to recieve the necessary legal defence if I am arrested, and that being arrested will not effect my chances of getting a desired job.'),
                    value: model.value["2"],
                    onChanged: (bool value) {
                      model.selectNeed("2", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.briefcase),
                  ),
                  CheckboxListTile(
                    title: const Text(
                        '3. I need to be invited to join by a friend'),
                    value: model.value["3"],
                    onChanged: (bool value) {
                      model.selectNeed("3", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.userFriends),
                  ),
                  CheckboxListTile(
                    title: const Text(
                        '4. I’m a party animal: I need to be invited to a party of other strikers and conditional strikers'),
                    value: model.value["4"],
                    onChanged: (bool value) {
                      model.selectNeed("4", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.fistRaised),
                  ),
                  CheckboxListTile(
                    title: const Text('5. I need transport to the event'),
                    value: model.value["5"],
                    onChanged: (bool value) {
                      model.selectNeed("5", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.bus),
                  ),
                  CheckboxListTile(
                    title: const Text('6. I need bail support'),
                    value: model.value["6"],
                    onChanged: (bool value) {
                      model.selectNeed("6", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.link),
                  ),
                  CheckboxListTile(
                    title: const Text('7. I need help with childcare'),
                    value: model.value["7"],
                    onChanged: (bool value) {
                      model.selectNeed("7", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.babyCarriage),
                  ),
                  CheckboxListTile(
                    title: const Text(
                        '8. I need housing (if long term strike and worry about losing housing)'),
                    value: model.value["8"],
                    onChanged: (bool value) {
                      model.selectNeed("8", value);
                    },
                    secondary: const Icon(FontAwesomeIcons.home),
                  ),
                  const SizedBox(height: 8.0),
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
