import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/common/profiles/widget/email.dart';
import 'package:namer_app/views/common/profiles/widget/modal.dart';
import 'package:namer_app/views/common/profiles/widget/phone_number.dart';
import 'package:namer_app/widgets/abstract_container2.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

class ParametersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        title: "Informations personnelles", fct: () => {}),
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
                                    return PopDialog(
                                      title: "Mot de passe",
                                      form: Form(
                                          child: Column(
                                        children: [
                                          TextFormField(),
                                          TextFormField()
                                        ],
                                      )),
                                    );
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
                                    return PhoneDialog(
                                      title: 'Numéro de téléphone',
                                    );
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
                                    return EmailDialog(
                                      title: "E-mail",
                                    );
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

class ParameterCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final dynamic content;

  const ParameterCard(
      {super.key, required this.title, this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithIcon(
          icon: icon,
          title: title,
        ),
        SizedBox(
          height: 20,
        ),
        content
      ],
    );
  }
}

class ParameterLine extends StatelessWidget {
  final dynamic fct;
  final String title;

  const ParameterLine({super.key, this.fct, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        await fct(context);
      }),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Expanded(flex: 0, child: Icon(Icons.arrow_forward_ios_rounded)),
        ],
      ),
    );
  }
}
