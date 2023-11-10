import 'package:flutter/material.dart';

import 'services/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background1.png"), fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 80,
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Connexion",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue.shade900)),
              SizedBox(
                height: 30,
              ),
              FormulaireLogin(),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Retour"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("init");
                    await AuthService().authAnonymous();
                    print("end");
                  },
                  child: Text("connexion anonyme")),
            ],
          ),
        ),
      ),
    );
  }
}

class Formulaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black, width: 5.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange.shade800,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'adress',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'password',
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          validator: (value) {
            if (value == null) {
              return 'Please';
            }
            setState(() {
              _adress = value;
            });
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Adresse ',
          ),
        ),TextFormField(
          validator: (value) {
            if (value == null) {
              return 'Please';
            }
            setState(() {
              _mdp = value;
            });
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Mot de passe',
          ),
        ),
        Container(
          padding: EdgeInsets.only(),
          child: ElevatedButton(
            onPressed: () async{
              if(_formKey.currentState!.validate()){
                await AuthService().authAdressPassword(_adress.toString(), _mdp.toString());
              }
            },
            child: const Text("bien"),
          ),
        )
      ]),
    );
  }
}
