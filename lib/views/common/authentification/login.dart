import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/type/rules_type.dart';

import '../../../util/color.dart';
import '../../inscription_page.dart';
import '../../navigation_no_indentify.dart';
import 'formulaire_connexion.dart';
import 'other_connexion.dart';

class LoginPage extends StatelessWidget {
  final RulesType title;

  LoginPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background1.png"),
                  fit: BoxFit.cover)),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 140,
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_circle_left_sharp,
                            color: Color.fromRGBO(170, 77, 79, 1),
                            size: MediaQuery.of(context).size.height * .04,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          "assets/logo.png",
                          height: MediaQuery.of(context).size.height * .04 * 2,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavigationNoIndentify()));
                          },
                          icon: Icon(Icons.cancel,
                              color: Color.fromRGBO(170, 77, 79, 1),
                              size: MediaQuery.of(context).size.height * .04),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
                endIndent: MediaQuery.of(context).size.height * .04,
                indent: MediaQuery.of(context).size.height * .04,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Connexion",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * .06,
                  color: Color.fromRGBO(235, 126, 26, 1),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Connectez-vous en tant que ${title == RulesType.USER_ASSOCIATION ? 'association' : 'bénévole'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * .03,
                  color: Colors.black87,
                ),
              ),
              FormulaireLogin(),
              Divider(
                color: Colors.grey.shade500,
                height: 20,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherConnection(
                                context,
                              ),
                            ),
                          );
                        });
                      },
                      child: FaIcon(FontAwesomeIcons.google),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 90,
                      indent: 12,
                      endIndent: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherConnection(
                                context,
                              ),
                            ),
                          );
                        });
                      },
                      child: FaIcon(FontAwesomeIcons.squareFacebook),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.60,
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inscription()),
                    );
                  },
                  child: Text("Créer un compte",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
