import 'package:flutter/material.dart';
import 'package:namer_app/widgets/switch_button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class NotificationsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsState();
  }
}

class _NotificationsState extends State<NotificationsDialog> {
  final _formKey = GlobalKey<FormState>();

  bool messages = false;

  @override
  Widget build(BuildContext context) {
    changeNewMessages(bool value) {
      setState(() {
        messages = value;
      });
    }

    return Column(children: [
      TitleWithIcon(title: "password", icon: Icon(Icons.admin_panel_settings)),
      Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              SwitchButton(
                value: messages,
                fct: changeNewMessages,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ))
    ]);
  }
}
