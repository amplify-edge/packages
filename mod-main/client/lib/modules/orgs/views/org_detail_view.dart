import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mod_main/modules/orgs/data/org_model.dart';
import 'package:maintemplate/core/events/event_bus.dart';
import 'package:maintemplate/core/events/org_event.dart';
import '../../../core/core.dart';

class OrgDetailView extends StatelessWidget {
  final Org org;

  const OrgDetailView({Key key, this.org}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        //   CarouselWithIndicator(imgList: campaign.videoURL),
        ListTile(
          title: Text(
            'Category',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.category),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Type of Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.actionType),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Action Location / Time',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              '${org.actionLocation} / ${DateFormat('yyyy MMM dd HH:MM').format(org.actionTime)}'),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Length of the Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text('${org.actionLength} ${org.uom}'),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Goal',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.goal),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Strategy',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.strategy),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Historical Precedents',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.histPrecedents),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Backing/Endorsing Organizations',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.backingOrg.join('\n')),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'People already pledged',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.alreadyPledged.toString()),
        ),
        const SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'We Need :',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: const Text(
                    'The following figures are extrapolated from similar past actions that both succeeded and failed',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                ListTile(
                  title: const Text('Pioneers needed to start'),
                  trailing: Text(
                    '${org.minPioneers}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                ListTile(
                  title: const Text('Rebels needed to trigger media'),
                  trailing: Text(
                    '${org.minRebelsForMedia}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                ListTile(
                  title: const Text('Rebels needed to win'),
                  trailing: Text(
                    '${org.minRebelsToWin}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Contact Details',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(org.contact),
        ),
        const SizedBox(height: 16.0),
        ButtonBar(children: [
          FlatButton(
            onPressed: () {
              Modular.to.pushNamed(
                  Modular.get<Paths>().myNeeds.replaceAll(':id', org.id));
            },
            child: Text("Not Ready"),
          ),
          RaisedButton(
            onPressed: () {
              behaviorBus.fire(OrgEvent(this.org));
              // TODO: Require help on this one, couldn't figure out why the paths aren't recognised...
              Modular.to.pushNamed(Modular.get<Paths>().login);
            },
            child: Text("Ready"),
          ),
        ]),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
