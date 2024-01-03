import 'package:flutter/material.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/parameters/notifications_dialog.dart';
import 'package:namer_app/views/common/profiles/parameters/widget/parameters_card.dart';
import 'package:namer_app/views/common/profiles/widget/email_dialog.dart';
import 'package:namer_app/views/common/profiles/widget/password_dialog.dart';
import 'package:namer_app/views/volunteers/profil/parameter/personal_informations.dart';
import 'package:namer_app/views/associtions/profil/parameters/personal_informations_asso.dart';
import 'package:namer_app/views/volunteers/profil/parameter/phone_number.dart';
import 'package:namer_app/views/associtions/profil/parameters/phone_number_asso.dart';
import 'package:namer_app/views/common/profiles/widget/pop_dialog.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class ParametersView extends StatelessWidget {
  RulesType rule = RulesType.NONE;

  ParametersView({required this.rule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                                    if (rule == RulesType.USER_VOLUNTEER) {
                                      return PopDialog(
                                        content: InformationDialog(),
                                      );
                                    } else {
                                      return PopDialog(
                                        content: InformationDialogAsso(),
                                      );
                                    }
                                  })
                            }),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(
                        title: "Notifications",
                        fct: (context) => {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopDialog(content: NotificationsDialog());
                                  })
                            }),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(title: "Langue", fct: (value) => {}),
                    Divider(
                      color: Colors.white,
                    ),
                    ParameterLine(title: "Détail Profil", fct: (value) => {}),
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
                                    if (rule == RulesType.USER_VOLUNTEER) {
                                      return PopDialog(content: PhoneDialog());
                                    } else {
                                      return PopDialog(
                                          content: PhoneDialogAsso());
                                    }
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
                    ParameterLine(
                        title: "Sécurité de compte", fct: (value) => {}),
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
                    ParameterLine(
                        title: "Informations légales", fct: (value) => {}),
                    SizedBox(
                      height: 15,
                    ),
                    ParameterLine(title: "Me déconnecter", fct: (value) => {}),
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
