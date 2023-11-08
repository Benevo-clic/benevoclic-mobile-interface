import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NavigationBarApp.dart';

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
          //reverse: true,
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
              hintText: 'Enter a search term',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
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

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: TextFormField(
            validator: (value) {
              if (value == null) {
                return 'Please';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {},
            child: Text("envoyer"),
          ),
        ),
      ],
    );
  }
}
