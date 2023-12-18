import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/util/color.dart';

import '../common/annonces/annonces.dart';
import '../common/messages/messages.dart';
import '../common/profiles/profil.dart';

class NavigationAssociation extends StatefulWidget {
  const NavigationAssociation({super.key});

  @override
  State<NavigationAssociation> createState() => _NavigationAssociationState();
}

class _NavigationAssociationState extends State<NavigationAssociation> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    Annonces(),
    Annonces(),
    Messages(),
    ProfilPage(),
  ];

  Widget buildNavigationIcon(String assetName, int index, {double? size}) {
    final bool isSelected = index == currentPageIndex;
    final Color iconColor = isSelected
        ? Color.fromRGBO(55, 94, 232, 1)
        : Color.fromRGBO(217, 217, 217,
            1); // Couleurs pour l'état sélectionné/non sélectionné

    return SvgPicture.asset(
      assetName,
      height: size ?? 24,
      color: iconColor,
    );
  }

  NavigationBar buildNavigationBar() {
    return NavigationBar(
      backgroundColor: Color.fromRGBO(255, 153, 85, 1),
      // Fond transparent
      selectedIndex: currentPageIndex,
      onDestinationSelected: (index) =>
          setState(() => currentPageIndex = index),
      indicatorColor: Colors.transparent,
      // Pas de ligne de sélection
      destinations: [
        NavigationDestination(
          icon: buildNavigationIcon('assets/icons/narbarannouncement.svg', 0),
          label: 'Annonces',
        ),
        NavigationDestination(
          icon: buildNavigationIcon('assets/icons/heart.svg', 1),
          label: 'Favoris',
        ),
        NavigationDestination(
          icon: buildNavigationIcon('assets/icons/chat.svg', 2),
          label: 'Messages',
        ),
        NavigationDestination(
          icon: buildNavigationIcon('assets/icons/profile.svg', 3),
          label: 'Profil',
        ),
        // Répétez pour les autres éléments...
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: marron, width: 2)), // Votre style
        ),
        child: buildNavigationBar(),
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
    );
  }
}
