import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/home_view.dart';

import 'common/annonces/announcement_common.dart';

class NavigationNoIndentify extends StatefulWidget {
  @override
  _NavigationNoIndentifyState createState() => _NavigationNoIndentifyState();
}

class _NavigationNoIndentifyState extends State<NavigationNoIndentify> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    AnnouncementCommon(),
    HomeView(title: "Vous devez être connecté"),
    HomeView(title: "Vous devez être connecté"),
    HomeView(title: "Vous devez être connecté"),
  ];
  Widget buildNavigationIcon(String assetName, int index, {double? size}) {
    final bool isSelected = index == currentPageIndex;

    // Logique pour l'état sélectionné
    if (isSelected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetName,
            height: size ?? 24,
            color: Color.fromRGBO(55, 94, 232, 1),
          ),
        ],
      );
    } else {
      return SvgPicture.asset(
        assetName,
        height: size ?? 24,
      );
    }
  }

  NavigationBar buildNavigationBar() {
    return NavigationBar(
      backgroundColor: Color.fromRGBO(255, 153, 85, 1),
      // Fond transparent
      selectedIndex: currentPageIndex,
      onDestinationSelected: (index) =>
          setState(() => currentPageIndex = index),
      indicatorColor: Colors.transparent,
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromRGBO(255, 153, 85, 1),
        color: marron,
        height: 60,
        index: currentPageIndex,
        items: <Widget>[
          SvgPicture.asset('assets/icons/narbarannouncement.svg',
              height: 24,
              color: currentPageIndex == 0
                  ? Color.fromRGBO(55, 94, 232, 1)
                  : Colors.white),
          SvgPicture.asset('assets/icons/heart.svg',
              height: 24,
              color: currentPageIndex == 1
                  ? Color.fromRGBO(55, 94, 232, 1)
                  : Colors.white),
          SvgPicture.asset('assets/icons/chat.svg',
              height: 24,
              color: currentPageIndex == 2
                  ? Color.fromRGBO(55, 94, 232, 1)
                  : Colors.white),
          SvgPicture.asset('assets/icons/profile.svg',
              height: 24,
              color: currentPageIndex == 3
                  ? Color.fromRGBO(55, 94, 232, 1)
                  : Colors.white),
        ],
        onTap: (index) => setState(() => currentPageIndex = index),
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
    );
  }
}
