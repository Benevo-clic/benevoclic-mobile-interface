import 'package:flutter/material.dart';

class ItemAnnouncement extends StatelessWidget {
  String nameAsso;
  int nbHours;
  int nbPlaces;
  int nbPlacesTaken;

  //Announcement announcement;

  ItemAnnouncement(
      {required this.nameAsso,
      required this.nbHours,
      required this.nbPlaces,
      required this.nbPlacesTaken});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }
}

class InformationAnnonce extends StatelessWidget {
  final Icon icon;
  final String text;

  InformationAnnonce({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, Text(text)],
    );
  }
}
