import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:namer_app/type/rules_type.dart';

import '../cubit/user/user_state.dart';
import '../views/common/authentification/login/statefullwIdgets/other_connexion.dart';
import 'auth_app_bar.dart';
import 'signup_form.dart';

class InscriptionWidget extends StatelessWidget {
  final RulesType rulesType;
  final UserState state;

  const InscriptionWidget(
      {super.key, required this.rulesType, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
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
                    AuthAppBar(
                      contexts: context,
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
                      "Inscription",
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
                      'Inscrivez-vous en tant que ${rulesType == RulesType.USER_ASSOCIATION ? "Association" : "Bénévole"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * .04,
                        color: Colors.black87,
                      ),
                    ),
                    SignupForm(rulesType: rulesType),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 25, right: 5),
                            // Ajustez selon vos besoins
                            child: Divider(
                              color: Colors.grey.shade400,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Text("OU"), // Texte à afficher au milieu
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, right: 25),
                            // Ajustez selon vos besoins
                            child: Divider(
                              color: Colors.grey.shade400,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
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
                                      context: context,
                                      rulesType: rulesType,
                                    ),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(FontAwesomeIcons.google),
                                // Icône Google
                                SizedBox(width: 10),

                                Text("Google"),
                                // Texte
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Divider(
                            color: Colors.black,
                            height: 100,
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
                                        context: context, rulesType: rulesType),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(FontAwesomeIcons.squareFacebook),
                                SizedBox(width: 10),
                                Text("Facebook"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              if (state is UserLoadingState) _buildLoading(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Fond semi-transparent noir
      width: double.infinity, // Couvre toute la largeur
      height: MediaQuery.of(context).size.height, // Couvre toute la hauteur
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
