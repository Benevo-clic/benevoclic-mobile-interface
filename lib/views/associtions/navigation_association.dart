import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/models/buildNavigation_model.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/build_navbar.dart';

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

  List<BuildNavigationModel> buildNavigationModel = [
    BuildNavigationModel(iconTitle: 'assets/icons/Menu.svg', label: 'Annonces'),
    BuildNavigationModel(
        iconTitle: 'assets/icons/Chat_alt.svg', label: 'Publier', size: 45),
    BuildNavigationModel(iconTitle: 'assets/icons/chat.svg', label: 'Messages'),
    BuildNavigationModel(
      iconTitle: 'assets/icons/profile.svg',
      label: 'Profil',
    ),
  ];

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
