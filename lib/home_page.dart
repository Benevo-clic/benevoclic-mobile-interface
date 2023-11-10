import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namer_app/loginController.dart';
import 'Login.dart';
import 'NavigationBarApp.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    //permet de ne pas changer l'orientation du telephone

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background1.png"), fit: BoxFit.cover)),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 150,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text("Se connecter",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => loginController()),
                      );
                    },
                    child: Text("Association"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade900,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationBarApp()),
                      );
                    },
                    child: Text("Bénévole"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas de compte ?"),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Inscris toi !",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  
                ],
              ),
            ),
          )),
    );
  }
}
