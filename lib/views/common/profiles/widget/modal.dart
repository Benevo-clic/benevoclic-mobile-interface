import 'package:flutter/material.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class PopDialog extends StatefulWidget {
  final String title;

  final Form form;

  PopDialog({required this.title, required this.form});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<PopDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 35, 0, 35),
        child: Column(
          children: [
            TitleWithIcon(
                title: widget.title, icon: Icon(Icons.admin_panel_settings)),
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
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  final dynamic fct;

  const FormWidget({super.key, this.fct});

  @override
  State<StatefulWidget> createState() {
    return _FormWidget();
  }
}

class _FormWidget extends State<FormWidget> {
  var _key;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: [],
        ));
  }
}
