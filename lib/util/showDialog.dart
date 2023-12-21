import 'package:flutter/material.dart';

import '../error/error_message.dart';

class ShowDialog {
  static void show(BuildContext context, String type, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorMessage(type: type, message: message);
      },
    );
  }
}

class ShowDialogYesNo {
  static void show(
      BuildContext context, String title, String message, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                onYes();
              },
            ),
          ],
        );
      },
    );
  }
}
