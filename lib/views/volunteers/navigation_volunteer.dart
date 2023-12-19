import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/util/color.dart';

import '../../cubit/page/page_cubit.dart';
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
          iconTitle: 'assets/icons/heart.svg', label: 'Favoris'),
      BuildNavigationModel(
          iconTitle: 'assets/icons/chat.svg', label: 'Messages'),
      BuildNavigationModel(
        iconTitle: 'assets/icons/profile.svg',
        label: 'Profil',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: marron, width: 2)), // Votre style
        ),
        child: BuldNavBar(
          buildNavigationModel: buildNavigationModel,
        ),
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          final pages = [Annonces(), Annonces(), Messages(), ProfilPage()];
          return IndexedStack(
            index: currentPageIndex,
            children: pages,
          );
        },
      ),
    );
  }
}
