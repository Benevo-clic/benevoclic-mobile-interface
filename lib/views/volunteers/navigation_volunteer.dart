import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/volunteers/profil/profil_volunteer.dart';

import '../../cubit/page/page_cubit.dart';
import '../../models/buildNavigation_model.dart';
import '../../widgets/build_navbar.dart';
import '../common/annonces/announcement_common.dart';
import '../common/messages/messages.dart';

class NavigationVolunteer extends StatefulWidget {
  const NavigationVolunteer({super.key});

  @override
  State<NavigationVolunteer> createState() => _NavigationVolunteerState();
}

class _NavigationVolunteerState extends State<NavigationVolunteer> {
  int currentPageIndex = 0;
  late List<BuildNavigationModel> buildNavigationModel;

  @override
  void initState() {
    super.initState();
    buildNavigationModel = [
      BuildNavigationModel(
          iconTitle: 'assets/icons/Menu.svg', label: 'Annonces', size: 30),
      BuildNavigationModel(
          iconTitle: 'assets/icons/heart.svg', label: 'Favoris'),
      BuildNavigationModel(
          iconTitle: 'assets/icons/chat.svg', label: 'Messages', size: 30),
      BuildNavigationModel(
        iconTitle: 'assets/icons/profile.svg',
        label: 'Profil',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuldNavBar(
        buildNavigationModel: buildNavigationModel,
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          final pages = [
            AnnouncementCommon(rulesType: RulesType.USER_VOLUNTEER),
            AnnouncementCommon(
              rulesType: RulesType.USER_VOLUNTEER,
            ),
            Messages(),
            ProfileView(title: RulesType.USER_VOLUNTEER)
          ];
          return IndexedStack(
            index: currentPageIndex,
            children: pages,
          );
        },
      ),
    );
  }
}
