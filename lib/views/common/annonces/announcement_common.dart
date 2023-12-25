import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/announcement/announcement_state.dart';
import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  List<Announcement> announcements = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncements();
  }

  final Announcement announcement = Announcement(
    dateEvent: '13/10/2021 12:00',
    datePublication: '3',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed non risus. Suspendisse lectus tortor, dignissim sit amet, '
        'adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. '
        'Maecenas ligula massa, varius a, semper congue, euismod non, mi. '
        'Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, '
        'non fermentum diam nisl sit amet erat.',
    location:
        LocationModel(address: '3 rue bis blabla', latitude: 0, longitude: 0),
    labelEvent: 'Distruibution de repas',
    nbHours: 3,
    nbPlaces: 20,
    type: 'type',
    idAssociation: 'idAssociation',
    nameAssociation: 'nameAssociation',
    nbPlacesTaken: 2,
  );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
              0.15), // Hauteur personnalisée
          child: AppBarSearch(
            contexts: context,
            label: 'Annonces',
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              int reversedIndex =
                  announcements.length - 1 - index; // Calcul de l'index inversé

              return ItemAnnouncement(
                key: ValueKey(announcements[reversedIndex].id),
                announcement: announcements[reversedIndex],
                isSelected: true,
              );
            },
            itemCount: announcements.length,
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is AnnouncementLoadedState) {
        announcements = state.announcements;
      }
    });
  }
}

