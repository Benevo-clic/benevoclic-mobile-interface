import 'package:flutter/material.dart';
import 'package:namer_app/views/common/annonces/widgets/item_announcement.dart';

class AnnouncementCommon extends StatefulWidget {
  @override
  State<AnnouncementCommon> createState() => _AnnouncementCommonState();
}

class _AnnouncementCommonState extends State<AnnouncementCommon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ItemAnnouncement(
                nameAsso: "Association 1",
                nbHours: 2,
                nbPlaces: 5,
                nbPlacesTaken: 2),
          ],
        ),
      ),
    );
  }
}

