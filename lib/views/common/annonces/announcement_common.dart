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
      appBar: AppBar(
        leading: const Icon(Icons.chevron_left),
        title: const Text('Paris'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
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

