import 'package:flutter/material.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class InformationDialog extends StatefulWidget {
  const InformationDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InformationDialog();
  }
}

class _InformationDialog extends State<InformationDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithIcon(
            title: "Informations personnelles",
            icon: Icon(Icons.perm_identity)),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              InputField(title: "Nom"),
              SizedBox(
                height: 10,
              ),
              InputField(title: "Prenom"),
              SizedBox(
                height: 10,
              ),
              InputField(title: "Date de naissance"),
              SizedBox(
                height: 10,
              ),
              InputField(title: "Numéro de naissance"),
              SizedBox(
                height: 10,
              ),
              InputField(title: "Adresse"),
              SizedBox(
                height: 10,
              ),
              Button(
                  text: "Sauvegarder",
                  color: Colors.black,
                  fct: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  backgroundColor: Colors.grey)
            ],
          ),
        ),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  final String title;

  const InputField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {},
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: "$title : ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}