import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

import 'common/annonces/annonces.dart';
import 'common/messages/messages.dart';
import 'common/profiles/profil.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: marron, width: 2)),
          ),
          child: NavigationBar(
            backgroundColor: orange,
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