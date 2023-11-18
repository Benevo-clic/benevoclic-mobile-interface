

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/color/color.dart';
import 'package:namer_app/other_connexion.dart';
import 'package:namer_app/pages/inscription_page.dart';
import 'package:namer_app/widgets/formulaire_connexion.dart';

import '../services/auth.dart';

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
              Text("Connexion",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue.shade700)),
              Text("Connectez-vous en tant que bénévole"),
              SizedBox(
                height: 30,
              ),
              FormulaireLogin(),
              SizedBox(
                height: 30,
              ),

              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Row(
                  children: [
                    Expanded(
                        child: OtherConnection(context, "Google",
                            FaIcon(FontAwesomeIcons.google))),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: OtherConnection(context, "Facebook",
                            FaIcon(FontAwesomeIcons.facebookF))),
                  ],
                ),
              ), //OtherConnection(context, "Google", FaIcon(FontAwesomeIcons.google)),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.60,
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Inscription()),);
                    //AuthService().createAccount("efef@fee.com","nonnon");
                  },
                  child: Text("Créer un compte",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
