

import 'package:flutter/material.dart';

class FolderView extends StatelessWidget {
  final String folderName;

  const FolderView({Key key, this.folderName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.folder),
      title: Text(folderName),
      onTap: (){
        
      },
    );
  }
}