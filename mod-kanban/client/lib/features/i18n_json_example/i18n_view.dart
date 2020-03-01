import 'package:flutter/material.dart';
import 'package:modkanban/core/i18n/app_localization.dart';

class I18NWithJsonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("i18n Example")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: SizedBox(
                height: 50,
                child: Text("Months name will be translated if you change \nlanguage in you device settings"),
            ),
             ),
            
            SizedBox(
              height: 50,
              child: Text(AppLocalizations.of(context)
                  .translate('dates_month_january')),
            ),
            Divider(),
            SizedBox(
              height: 50,
              child: Text(AppLocalizations.of(context)
                  .translate('dates_month_february')),
            ),
            Divider(),
            SizedBox(
              height: 50,
              child: Text(AppLocalizations.of(context)
                  .translate('dates_month_march')),
            ),
            Divider(),
            SizedBox(
              height: 50,
              child: Text(AppLocalizations.of(context)
                  .translate('dates_month_april')),
            ),
             Divider(),
              SizedBox(
              height: 50,
              child: Text("Note : Choose Espanol(es) , Spanish(fr)\n for test purpose"),
            ),
           
          ],
        ),
      ),
    );
  }
}