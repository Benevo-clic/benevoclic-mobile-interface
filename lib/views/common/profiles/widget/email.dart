import 'package:flutter/material.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class EmailDialog extends StatefulWidget {
  final String title;

  const EmailDialog({super.key, required this.title});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<EmailDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 35, 0, 35),
        child: Column(
          children: [
            TitleWithIcon(title: widget.title, icon: Icon(Icons.mail)),
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
                        hintText: "E-mail",
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
