import 'package:flutter/material.dart';

import '../../../../models/announcement_model.dart';

class ItemAnnouncement extends StatelessWidget {
  final Announcement announcement;
  final bool isSelected;

  ItemAnnouncement({required this.announcement, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * .26;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 220,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 6),
          ),
        ],
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          announcement.image ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${announcement.nameAssociation}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'il y\'a ${announcement.datePublication} jours',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => print('favoris'),
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InformationAnnonce(
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 16,
                        ),
                        text: announcement.location.address,
                        size: 11,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InformationAnnonce(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                          size: 16,
                        ),
                        text: announcement.dateEvent,
                        size: 11,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InformationAnnonce(
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 16,
                        ),
                        text: '${announcement.nbHours} heures',
                        size: 11,
                      ),
                      InformationAnnonce(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 16,
                        ),
                        text:
                            '${announcement.nbPlacesTaken} / ${announcement.nbPlaces}',
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                announcement.labelEvent,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.black,
                endIndent: width * .06,
                indent: width * .06,
              ),
              Text(
                announcement.description,
                style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InformationAnnonce extends StatelessWidget {
  final Icon icon;
  final String text;
  double? size;

  InformationAnnonce({required this.icon, required this.text, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [icon, Text(text, style: TextStyle(fontSize: size ?? 14))],
    );
  }
}
