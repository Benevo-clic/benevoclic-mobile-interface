
import 'package:flutter/material.dart';
import 'package:namer_app/repositories/google/auth_repository.dart';
import 'package:namer_app/util/password_verification.dart';
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

  String? _mdp;

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
                validator: (value) {
                  
                  PasswordVerification password = PasswordVerification(value!);
                  if (!password.security()) {
                    return password.message;
                  }
                  _mdp = value;
                  return null;
                },
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
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_mdp!.length >= 8) {
                        print(_mdp);
                        AuthRepository().changePassword(_mdp.toString());
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("changer mot de passe"))
            ],
          ),
        ),
      ],
    );
  }
}
