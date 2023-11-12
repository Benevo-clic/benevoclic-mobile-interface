import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'formulaireConnexion.dart';
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
                      child: Center(),
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
                width: MediaQuery.sizeOf(context).width * 0.40,
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade300),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ))),
                  onPressed: () async {
                    await AuthService().singInWithGoogle();
                  },
                  child: Row(
                    children: [
                      Expanded(child: FaIcon(FontAwesomeIcons.google)),
                      Text("Google", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),

              /*TextButton(
                /*style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),*/

                onPressed: (){},  
                child: Row(
                children: [
                      FaIcon(FontAwesomeIcons.google),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Google",
                            style: TextStyle(color: Colors.black)),
                      
                    ],
              )),*/
              ElevatedButton(
                  onPressed: () async {
                    print("init");
                    await AuthService().authAnonymous();
                    print("end");
                  },
                  child: Text("connexion anonyme")),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.60,
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(249, 148, 85, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {},
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
