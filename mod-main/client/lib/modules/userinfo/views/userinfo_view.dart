import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../view_model/userinfo_view_model.dart';

class UserInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: UserInfoViewModel(),
      builder: (context, UserInfoViewModel model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text(
              '1. Where are you?',
              style: Theme.of(context).textTheme.title,
            )),
            ListTile(
              title: _select((value) { model.changeCountry(value);}, model.selectedCountry, model.countries),
            ),
            ListTile(
              title: _select((value) {model.changeCity(value);},  model.selectedCity, model.cities)
            ),
            ListTile(
              title: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Zip Code',
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            ListTile(
              title: Text(
                '2. Travel distance you can afford?',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ListTile(
              title: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Distance in KM',
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            ListTile(
              title: Text(
                '3. Age',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ListTile(title: _select((value) { model.changeAge(value);}, model.selectedAge, model.age)),
            const SizedBox(height: 48.0),
            ListTile(
              title: Text(
                '4. Any Campaign Affiliations ?',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ListTile(
              title: _select((value) { model.changeAffiliation(value);}, model.selectedCampaignAffiliation, model.campaignAffiliations)),
            
            const SizedBox(height: 48.0),
            ListTile(
              title: ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                     model.navigateNext();
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
          // ),
          //   ),
        ),
      )),
    );
  }

  Widget _select(Function onChanged,String value, List<String> items) {
    return DropdownButton<String>(
      value: value,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 5,
      isExpanded: true,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
