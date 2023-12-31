import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/announcement/announcement_cubit.dart';
import '../../cubit/page/page_cubit.dart';
import '../../models/buildNavigation_model.dart';
import '../../widgets/build_navbar.dart';
import '../common/annonces/announcement_common.dart';
import '../common/messages/messages.dart';
import '../common/profiles/profil.dart';
import 'favoris/favorites_volunteers_views.dart';

class NavigationVolunteer extends StatefulWidget {
  const NavigationVolunteer({super.key});

  @override
  State<NavigationVolunteer> createState() => _NavigationVolunteerState();
}

class _NavigationVolunteerState extends State<NavigationVolunteer> {
  int currentPageIndex = 0;
  late List<BuildNavigationModel> buildNavigationModel;
  String? _idVolunteer; // Make it nullable

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
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _idVolunteer = prefs.getString('idVolunteer') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuldNavBar(
        buildNavigationModel: buildNavigationModel,
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
          if (_idVolunteer == null) {
            return CircularProgressIndicator();
          }
          BlocProvider.of<FavoritesAnnouncementCubit>(context)
              .getFavoritesAnnouncementByVolunteerId(_idVolunteer!);

          return IndexedStack(
            index: currentPageIndex,
            children: [
              AnnouncementCommon(
                  rulesType: RulesType.USER_VOLUNTEER,
                  idVolunteer: _idVolunteer!),
              FavoritesVolunteer(
                rulesType: RulesType.USER_VOLUNTEER,
                idVolunteer: _idVolunteer!,
              ),
              Messages(),
              ProfileView(title: RulesType.USER_VOLUNTEER)
            ],
          );
        },
      ),
    );
  }
}
