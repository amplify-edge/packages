import 'dart:async';

class DialogService{

  Function _showDialogListener;
  Completer _dialogCompleter;

  void registerDialogService(Function(AlertRequest) showDialogListener){
    _showDialogListener = showDialogListener;
  }


  Future showDialog({String title, String description, String buttonTitle = 'OK'}){
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(
      AlertRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle
      )
    );
    return _dialogCompleter.future;
  }


  void dialogComplete(AlertResponse response){
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

}

class AlertRequest{
  final String title;
  final String description;
  final String buttonTitle;

  AlertRequest({this.title, this.description, this.buttonTitle});
}



class AlertResponse{
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  AlertResponse({this.fieldOne, this.fieldTwo, this.confirmed});
}