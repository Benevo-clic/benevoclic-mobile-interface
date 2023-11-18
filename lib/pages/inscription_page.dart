import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/error/error_message.dart';
import 'package:namer_app/services/auth.dart';

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background1.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.backspace_outlined),
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          "assets/logo.png",
                          height: 80,
                        ),
                      ),
                      Expanded(
                        child: Text(""),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Inscription",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(235, 126, 26, 1))),
                Text("Inscrivez-vous en tant que bénévole"),
                SizedBox(
                  height: 30,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30),
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    child: FormulaireInscription()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormulaireInscription extends StatefulWidget {
  const FormulaireInscription({super.key});

  @override
  State<FormulaireInscription> createState() => _FormulaireInscriptionState();
}

class _FormulaireInscriptionState extends State<FormulaireInscription> {
  final myController = TextEditingController();

  var _adress;
  var _mdp;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.deepOrange, width: 2)),
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
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Adresse mail ou numéro de téléphone',
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
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.key_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Créez votre mot de passe',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {},
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.key_rounded),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              hintText: 'Confirmez votre mot de passe',
            ),
          ),
          SizedBox(
            height: 5,
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
                  await AuthService()
                      .createAccount(_adress.toString(), _mdp.toString());
                } on FirebaseAuthException catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorMessage(
                            type: "inscription incorrect", message: "retour");
                      });
                }}
              },
              child: const Text("Inscription",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Vous avez déjà un compte ?",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}

class EmailVerification {
  var email = "";
  var message = "";

  EmailVerification(String emailParam) {
    email = emailParam;
  }

  security() {
    if (email.isEmpty) {
      message = "Veuillez remplir ce champs avec un email";
      return false;
    }

    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    }
    message = "Cet email ne possède pas un bon format";
    return false;
  }
}
