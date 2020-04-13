import 'package:flutter/material.dart';
import 'package:maintemplate/core/events/event_bus.dart';
import 'package:maintemplate/core/events/org_event.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<OrgEvent>(
            stream: behaviorBus.on<OrgEvent>(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text('Sign in with org: ${snapshot.data.org.campaignName}')
                  : Text('Sign in with no org found');
            }),
      ),
    );
  }
}
