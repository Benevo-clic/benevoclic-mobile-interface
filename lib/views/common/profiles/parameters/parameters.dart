import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/parameters/widget/parameters_card.dart';
import 'package:namer_app/views/common/profiles/widget/email_dialog.dart';
import 'package:namer_app/views/common/profiles/widget/password_dialog.dart';
import 'package:namer_app/views/common/profiles/widget/personal_informations.dart';
import 'package:namer_app/views/common/profiles/widget/phone_number.dart';
import 'package:namer_app/views/common/profiles/widget/pop_dialog.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class ParametersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: orange,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          AbstractContainer2(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ParameterCard(
                title: "Préférence",
                icon: Icon(Icons.info),
                content: Column(
                  children: [
                    ParameterLine(
                        title: "Informations personnelles",
                        fct: (context) => {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopDialog(
                                      content: InformationDialog(),
                                    );
                                  })
                            }),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(title: "Notifications", fct: () => {}),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(title: "Langue", fct: () => {}),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(title: "Détail Profil", fct: () => {}),
                  ],
                ),
              ),
            ],
          )),
          Divider(
            color: Colors.white,
          ),
          AbstractContainer2(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ParameterCard(
                title: "Connexion et Sécurité",
                icon: Icon(Icons.shield_rounded),
                content: Column(
                  children: [
                    ParameterLine(
                        title: "Mot de passe",
                        fct: (context) => {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopDialog(content: PasswordDialog());
                                  })
                            }),
                    SizedBox(
                      height: 15,
                    ),
                    ParameterLine(
                        title: "Numéro de téléphone",
                        fct: (context) => {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return PopDialog(content: PhoneDialog());
                                  }))
                            }),
                    SizedBox(
                      height: 15,
                    ),
                    ParameterLine(
                        title: "E-mail",
                        fct: (context) => {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopDialog(content: EmailDialog());
                                  }),
                            }),
                    SizedBox(
                      height: 15,
                    ),
                    ParameterLine(title: "Sécurité de compte", fct: () => {}),
                  ],
                ),
              ),
            ],
          )),
          Divider(
            color: Colors.white,
          ),
          AbstractContainer2(
              content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ParameterCard(
                title: "Aide",
                icon: Icon(Icons.question_mark_outlined),
                content: Column(
                  children: [
                    ParameterLine(title: "Informations légales", fct: () => {}),
                    SizedBox(
                      height: 15,
                    ),
                    ParameterLine(title: "Me déconnecter", fct: () => {}),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
