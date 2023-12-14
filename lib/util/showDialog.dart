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
