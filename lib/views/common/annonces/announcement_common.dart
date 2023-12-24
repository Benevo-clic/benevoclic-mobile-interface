import 'package:flutter/material.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement.dart';

import '../../../widgets/app_bar_search.dart';

class AnnouncementCommon extends StatefulWidget {
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.15), // Hauteur personnalisée
        child: AppBarSearch(),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ItemAnnouncement(
                  nameAsso: "Association 2",
                  nbHours: 2,
                  nbPlaces: 5,
                  nbPlacesTaken: 2);
            },
            itemCount: 300,
          ),
        ),
      ),
    );
  }
}

