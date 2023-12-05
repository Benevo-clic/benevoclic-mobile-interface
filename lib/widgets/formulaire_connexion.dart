import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/error/error_message.dart';
import 'package:namer_app/util/email_verification.dart';

import '../services/firebase/auth.dart';

class FormulaireLogin extends StatefulWidget {
  const FormulaireLogin({super.key});

  @override
  State<FormulaireLogin> createState() => _FormulaireLoginState();
}

class _FormulaireLoginState extends State<FormulaireLogin> {
  final myController = TextEditingController();

  var _adress;
  var _mdp;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(249, 148, 85, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.brown, width: 2)),
      padding: EdgeInsets.all(25),
      width: MediaQuery.of(context).size.width * .85,
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              var email = EmailVerification(value.toString());
              if (email.security()) {
                setState(() {
                  _adress = value;
                });
                return null;
              } else {
                return email.message;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade400,
              prefixIcon: Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez rentrer un mot de passe";
              } else {
                setState(() {
                  _mdp = value;
                });
                return null;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade400,
              prefixIcon: Icon(Icons.key_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Mot de passe oublié ?",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.60,
            padding: EdgeInsets.only(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(150, 62, 96, 1),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await AuthService().authAdressPassword(
                        _adress.toString(), _mdp.toString());
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ErrorMessage(
                              type: "login incorrect", message: "retour");
                        });
                  }
                }
              },
              child: const Text("Connexion",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
