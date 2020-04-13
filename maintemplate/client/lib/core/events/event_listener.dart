


// import 'dart:async';

// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:rxdart/rxdart.dart';

// import '../core.dart';
// import 'event_bus.dart';
// import 'org_event.dart';

// class EventListener {
//   StreamSubscription subscription;

//   EventListener() {
//     listenForOrgEvent();
//   }

//   void listenForOrgEvent() {
//     if (subscription != null) {
//       logOutput('Already listening for an event.');
//     } else {
//       // -------------------------------------------------
//       // Listen for Event A
//       // -------------------------------------------------
//       subscription = eventBus.on<OrgEvent>().listen((event) {
//        // Modular.to.pushNamed(Paths.modGeo);
//         logOutput("Event ${event.org} Listened");
//       });
    
//       logOutput('Listening for Org Event');
//      // subscription.cancel();
//     }
//   }

//   // void listenForEventB() {
//   //   if (subscription != null) {
//   //     logOutput('Already listening for an event.');
//   //   } else {
//   //     // -------------------------------------------------
//   //     // Listen for Event B
//   //     // -------------------------------------------------
//   //     subscription = eventBus.on<MyEventB>().listen((MyEventB event) {
//   //       logOutput(event.text);
//   //     });
//   //     logOutput('---');
//   //     logOutput('Listening for Event B');
//   //     logOutput('---');
//   //   }
//   // }

//   // void pause() {
//   //   if (subscription != null) {
//   //     subscription.pause();
//   //     logOutput('Subscription paused.');
//   //   } else {
//   //     logOutput('No subscription, cannot pause!');
//   //   }
//   // }

//   // void resume() {
//   //   if (subscription != null) {
//   //     subscription.resume();
//   //     logOutput('Subscription resumed.');
//   //   } else {
//   //     logOutput('No subscription, cannot resume!');
//   //   }
//   // }

//   // void cancel() {
//   //   if (subscription != null) {
//   //     subscription.cancel();
//   //     subscription = null;
//   //     logOutput('Subscription canceled.');
//   //   } else {
//   //     logOutput('No subscription, cannot cancel!');
//   //   }
//   // }

//   void logOutput(String text) {
//     print("============================================");
//     print("\n");
//     print(text);
//     print("\n");
//     print("============================================");
//   }
// }