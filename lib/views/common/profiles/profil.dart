import 'package:flutter/material.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/background.dart';

import '../authentification/login/widgets/login.dart';
import '../authentification/repository/auth_repository.dart';
import 'modif_profil.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Background(
        image: "assets/background4.png",
        widget: Column(children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(child: Text("")),
              Expanded(
                  child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifProfil()),
                  );
                },
                ),
              ),
            ],
          ),
          Image.asset("assets/logo.png", height: 200),
          Text("Corentin ", style: TextStyle()),
          SizedBox(
            height: 20,
          ),
          Bio(text: "oui"),
          SizedBox(
            height: 20,
          ),
          LineProfil(
              text: "Historique de missions",
              icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.map_rounded),
              )),
          SizedBox(
            height: 20,
          ),
          LineProfil(
              text: "Paramètres",
              icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )),
          SizedBox(
            height: 20,
          ),
          LineProfil(
              text: "Suppression compte",
              icon: IconButton(
                onPressed: () async {
                  await AuthRepository().deleteAccount();
                },
                icon: Icon(Icons.no_accounts_sharp),
              )),
              SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await AuthRepository().logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      title: RulesType.USER_VOLUNTEER,
                    ),
                  ),
                );
              },
              child: Text("Déconnexion")),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

class LineProfil extends StatelessWidget {
  final String text;
  final icon;

  const LineProfil({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
      content: Row(
        children: [
          Expanded(
            flex: 0,
            child: IconButton(
              onPressed: () async {
                await AuthRepository().logout();
              },
              icon: icon,
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class Bio extends StatelessWidget {
  final String text;

  Bio({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Bio"),
        SizedBox(height: 5),
        Text(
            "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. ")
      ],
    ));
  }
}
