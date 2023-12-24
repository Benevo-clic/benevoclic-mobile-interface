import 'package:flutter/material.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement.dart';

import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
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
    image: 'https://via.placeholder.com/150',
    idAssociation: 'idAssociation',
    nameAssociation: 'nameAssociation',
    nbPlacesTaken: 2,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.15), // Hauteur personnalisée
        child: AppBarSearch(
          contexts: context,
          label: 'Annonces',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ItemAnnouncement(
              announcement: announcement,
              isSelected: true,
            );
          },
          itemCount: 300,
        ),
      ),
    );
  }
}

