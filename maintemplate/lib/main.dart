import 'package:flutter/material.dart';
import 'package:maintemplate/features/responvive_builder_example/responsive_template.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: App()));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,  MaterialPageRoute(builder: (context){
                      return ResponsiveTemplate();
                    }));
                
                  
                },
                child: Container(
                    child: Center(
                  child: Text("Responsive Builder"),
                )),
              ),
            ),
            Divider(),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                    Navigator.push(context,  MaterialPageRoute(builder: (context){
                      return ResponsiveTemplate();
                    }));
                },
                child: Container(
                    child: Center(
                  child: Text("Responsive Scaffold"),
                )),
              ),
            ),
          ],
        ));
  }
}
