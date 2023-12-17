import 'package:flutter/material.dart';
import 'package:namer_app/util/phone_number_verification.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class PhoneDialog extends StatefulWidget {
  const PhoneDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopDialog();
  }
}

class _PopDialog extends State<PhoneDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithIcon(
            title: "Numéro de téléphone",
            icon: Icon(Icons.phone_android_sharp)),
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              TextFormField(
                validator: (value) {
                  var phone = PhoneVerification(value.toString());
                  if (phone.security()) {
                    setState(() {
                      _phone = value;
                    });
                    return null;
                  } else {
                    return phone.message;
                  }
                },
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Numéro de téléphone",
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