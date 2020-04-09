// import 'package:flutter/material.dart';

// class OfficialNavRail extends StatefulWidget {
//   @override
//   _OfficialNavRailState createState() => _OfficialNavRailState();
// }

// class _OfficialNavRailState extends State<OfficialNavRail> {
  
//   @override
//   Widget build(BuildContext context) {
//     int _selectedIndex = 0;
//     return Scaffold(
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           NavigationRail(
//             backgroundColor: Colors.white54,
//             extended: true,
//             labelType: NavigationRailLabelType.none,
//             selectedLabelTextStyle: TextStyle(
//                color: Theme.of(context).accentColor,
        
//             ),
//             selectedIconTheme: IconThemeData(
//              color: Theme.of(context).accentColor,

//             ),
//             unselectedLabelTextStyle: TextStyle(
//                color: Theme.of(context).primaryColor,
//              fontSize: 20
//             ),
//             unselectedIconTheme: IconThemeData(
//              color: Theme.of(context).primaryColor,

//             ),
//             minExtendedWidth: 200,
//             // elevation: 2,
//               onDestinationSelected: (int index) {
//                 print(index);
//                 setState(() {
//                   _selectedIndex = index;
                  
//                 });
                
//               },
//               destinations: [
//                 NavigationRailDestination(
//                     icon: Icon(Icons.home), label: Text("Home")),
//                  NavigationRailDestination(
//                     icon: Icon(Icons.home), label: Text("Folders")),
//                  NavigationRailDestination(
//                     icon: Icon(Icons.home), label: Text("Gallery"))
//               ],
//               selectedIndex: _selectedIndex),
//               Center(
//                 child:Text(_selectedIndex.toString())
//               )
//         ],
//       ),
//     );
//   }
// }
