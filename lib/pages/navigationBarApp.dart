import 'package:flutter/material.dart';
import 'package:namer_app/pages/annonces/annonces.dart';
import 'package:namer_app/pages/messages/messages.dart';

import 'profil/profil.dart';

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
                label: 'Annonces',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                label: 'Favoris',
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
          Annonces(),
          Annonces(),
          Messages(),
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
