import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';

import '../../models/buildNavigation_model.dart';
import '../../widgets/build_navbar.dart';
import '../common/annonces/annonces.dart';
import '../common/messages/messages.dart';
import '../common/profiles/profil.dart';

class NavigationVolunteer extends StatefulWidget {
  const NavigationVolunteer({super.key});

  @override
  State<NavigationVolunteer> createState() => _NavigationVolunteerState();
}

class _NavigationVolunteerState extends State<NavigationVolunteer> {
  int currentPageIndex = 0;
  late List<BuildNavigationModel> buildNavigationModel;
  final List<Widget> pages = [
    Annonces(),
    Annonces(),
    Messages(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    buildNavigationModel = [
      BuildNavigationModel(
          iconTitle: 'assets/icons/Menu.svg', label: 'Annonces'),
      BuildNavigationModel(
          iconTitle: 'assets/icons/heart.svg', label: 'Favoris', size: 28),
      BuildNavigationModel(
          iconTitle: 'assets/icons/chat.svg', label: 'Messages'),
      BuildNavigationModel(
        iconTitle: 'assets/icons/profile.svg',
        label: 'Profil',
      ),
    ];
  }

  BuildNavBar buildNavigationBar() {
    return BuildNavBar(
      currentPageIndex: currentPageIndex,
      buildNavigationModel: buildNavigationModel,
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index;
        });
      },
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
