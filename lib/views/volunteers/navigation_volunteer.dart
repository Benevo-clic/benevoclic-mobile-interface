import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/type/rules_type.dart';
import 'package:namer_app/views/volunteers/announcement/announcement_volunteer.dart';
import 'package:namer_app/views/volunteers/profil/profil_volunteer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/announcement/announcement_cubit.dart';
import '../../cubit/announcement/announcement_state.dart';
import '../../cubit/page/page_cubit.dart';
import '../../models/buildNavigation_model.dart';
import '../../repositories/api/volunteer_repository.dart';
import '../../util/color.dart';
import '../../widgets/build_navbar.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    getIdVolunteer();
    BlocProvider.of<PageCubit>(context).setPage(0);
    BlocProvider.of<AnnouncementCubit>(context)
        .changeState(AnnouncementInitialState());
  }

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
      _idVolunteer = preferences.getString('idVolunteer')!;
    });
    if (_idVolunteer.isNotEmpty) {
      var currentVolunteer =
          await VolunteerRepository().getVolunteer(_idVolunteer);

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
            return SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : marron,
                  ),
                );
              },
            );
          }
          BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();

          return IndexedStack(
            index: currentPageIndex,
            children: [
              AnnouncementVolunteer(idVolunteer: _idVolunteer),
              FavoritesVolunteer(
                idVolunteer: volunteer!.id!,
              ),
              Messages(rulesType: RulesType.USER_VOLUNTEER),
              ProfilPageVolunteer(volunteer: volunteer!)
            ],
          );
        },
      ),
    );
  }
}
