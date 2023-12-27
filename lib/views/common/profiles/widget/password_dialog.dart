import 'package:flutter/material.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class PasswordDialog extends StatefulWidget {
  PasswordDialog();

  @override
  State<StatefulWidget> createState() {
    return _PasswordDialog();
  }
}

class _PasswordDialog extends State<PasswordDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithIcon(
            title: "password", icon: Icon(Icons.admin_panel_settings)),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Ancien mot de passe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "nouveau mot de passe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Button(
                  text: "Sauvegarder",
                  color: Colors.black,
                  fct: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.grey)
            ],
          ),
        ),
      ],
    );
  }
}
