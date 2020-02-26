
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../locator.dart';
import '../core.dart';


class DialogMangerWidget extends StatefulWidget {
  final Widget child;

  const DialogMangerWidget({Key key, this.child}) : super(key: key);
  @override
  _DialogManagerWidgetState createState() => _DialogManagerWidgetState();
}

class _DialogManagerWidgetState extends State<DialogMangerWidget> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogService(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
   Alert(
      context: context,
      type: AlertType.error,
      title: request.title,
      desc: request.description,
      closeFunction:() => _dialogService.dialogComplete(AlertResponse(confirmed: false)),
      buttons: [
        DialogButton(
          color: themeData.accentColor,
          child: Text(
            request.buttonTitle,
            style: themeData.textTheme.bodyText1,
          ),
          onPressed: () { 
            _dialogService.dialogComplete(AlertResponse(confirmed: true));
            Navigator.pop(context);},
          width: 120,
        )
      ],
    ).show();
  }
}
