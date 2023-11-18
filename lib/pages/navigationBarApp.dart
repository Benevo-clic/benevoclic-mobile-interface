import 'package:flutter/material.dart';
import 'package:namer_app/widgets/listeAnnonces.dart';

import '../profil.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //AuthService().getToken();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(150, 62, 96, 1), width: 2)),
          ),
          child: NavigationBar(
            backgroundColor: Color.fromRGBO(249, 148, 85, 1),
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.amber[800],
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Accueil',
              ),
              NavigationDestination(
                icon: Icon(Icons.search),
                label: 'Recherche',
              ),
              NavigationDestination(
                //selectedIcon: Icon(Icons.search),
                icon: Icon(Icons.message),
                label: 'Messages',
              ),
              NavigationDestination(
                //selectedIcon: Icon(Icons.school),
                icon: Icon(Icons.account_circle),
                label: 'Profil',
              ),
            ],
          ),
        ),
        body: <Widget>[
          ListeAnnonces(),
          ListeAnnonces(),
          Container(alignment: Alignment.center, child: Text("")),
          ProfilPage(),
        ][currentPageIndex],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String mot;

  const Item({super.key, required this.mot});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.amber[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business),
            Text(mot),
          ],
        ));
  }
}

/*class Annonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(children: [
        SizedBox(height: 50),
        Text("Mon annonce",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 50),
        Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, width: 3.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(children: [
              Container(
                  width: 250,
                  padding: EdgeInsets.all(15),
                  child: Text("Une bonne annonce et hop c'est dans la poche !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ))),
              LineContent(titreSection: "nombre de benevoles"),
              LineContent(titreSection: "nombre d'heures de la mission"),
              LineContent(titreSection: "Date et heure de la mission"),
              LineContent(titreSection: "Localisation de la mission"),
            ])),
      ]),
    );
  }
}*/

//abstract class
class LineContent extends StatelessWidget {
  final String titreSection;

  const LineContent({super.key, required this.titreSection});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade500)),
          padding: const EdgeInsets.all(6.0),
          child: Text(titreSection,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              )),
        )
      ],
    );
  }
}
