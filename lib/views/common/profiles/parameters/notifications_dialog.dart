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
              TitleWithSwitch(content: SwitchButton(
                value: messages,
                fct: changeNewMessages,
              ), text: "Mise en ligne des annonces"),
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

class TitleWithSwitch extends StatelessWidget {
  String text;
  dynamic content;

  TitleWithSwitch({required this.text, required this.content});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(child: Text(text)), content],
    );
  }
}
