import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/volunteers/profil/profil_volunteer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/announcement/announcement_cubit.dart';
import '../../cubit/favorisAnnouncement/favorites_announcement_cubit.dart';
import '../../cubit/page/page_cubit.dart';
import '../../models/buildNavigation_model.dart';
import '../../repositories/api/volunteer_repository.dart';
import '../../widgets/build_navbar.dart';
import '../common/annonces/announcement_common.dart';
import '../common/messages/messages.dart';
import 'favoris/favorites_volunteers_views.dart';

class NavigationVolunteer extends StatefulWidget {
  Volunteer? volunteer;

  NavigationVolunteer({super.key, this.volunteer});

  @override
  State<NavigationVolunteer> createState() => _NavigationVolunteerState();
}

class _NavigationVolunteerState extends State<NavigationVolunteer> {
  int currentPageIndex = 0;
  late String _idVolunteer; // Make it nullable
  Volunteer? volunteer;

  @override
  void initState() {
    super.initState();
    getIdVolunteer();
    _idVolunteer = '';
  }

  List<BuildNavigationModel> buildNavigationModel = [
    BuildNavigationModel(
        iconTitle: 'assets/icons/Menu.svg', label: 'Annonces', size: 30),
    BuildNavigationModel(iconTitle: 'assets/icons/heart.svg', label: 'Favoris'),
    BuildNavigationModel(
        iconTitle: 'assets/icons/chat.svg', label: 'Messages', size: 30),
    BuildNavigationModel(
      iconTitle: 'assets/icons/profile.svg',
      label: 'Profil',
    ),
  ];

  getIdVolunteer() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _idVolunteer = preferences.getString('idVolunteer')! ?? '';
    });
    if (_idVolunteer.isNotEmpty) {
      var currentVolunteer =
          await VolunteerRepository().getVolunteer(_idVolunteer!);

      if (!mounted) return;

      if (currentVolunteer != null) {
        setState(() {
          volunteer = currentVolunteer;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuldNavBar(
        buildNavigationModel: buildNavigationModel,
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (context, currentPageIndex) {
          if (volunteer == null) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();

          BlocProvider.of<FavoritesAnnouncementCubit>(context)
              .getFavoritesAnnouncementByVolunteerId(volunteer!.id!);

          return IndexedStack(
            index: currentPageIndex,
            children: [
              AnnouncementCommon(
                  rulesType: RulesType.USER_VOLUNTEER,
                  idVolunteer: _idVolunteer),
              FavoritesVolunteer(
                idVolunteer: _idVolunteer,
              ),
              Messages(),
              ProfilPageVolunteer(volunteer: volunteer!)
            ],
          );
        },
      ),
    );
  }
}
