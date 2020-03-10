import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mod_main/modules/campaign/data/campaign_model.dart';

class CampaignDetailView extends StatelessWidget {
  final Campaign campaign;

  const CampaignDetailView({Key key, this.campaign}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(campaign.logoUrl),
              ),
              title: Text(
                campaign.campaignName,
                //style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ),
        //   CarouselWithIndicator(imgList: campaign.videoURL),
        ListTile(
          title: Text(
            'Category',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.category),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Type of Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.actionType),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Action Location / Time',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              '${campaign.actionLocation} / ${DateFormat('yyyy MMM dd HH:MM').format(campaign.actionTime)}'),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Length of the Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text('${campaign.actionLength} ${campaign.uom}'),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Goal',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.goal),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Strategy',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.strategy),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Historical Precedents',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.histPrecedents),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Backing/Endorsing Organizations',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.backingOrg.join('\n')),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'People already pledged',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.alreadyPledged.toString()),
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
                    '${campaign.minPioneers}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                ListTile(
                  title: const Text('Rebels needed to trigger media'),
                  trailing: Text(
                    '${campaign.minRebelsForMedia}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                ListTile(
                  title: const Text('Rebels needed to win'),
                  trailing: Text(
                    '${campaign.minRebelsToWin}',
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
          subtitle: Text(campaign.contact),
        ),
        const SizedBox(height: 16.0),
        ButtonBar(children: [
          RaisedButton(
            onPressed: () {},
            child: Text("Ready"),
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Not Ready"),
          ),
        ]),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
