import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namer_app/util/manage_date.dart';
import 'package:namer_app/widgets/information_announcement.dart';

import '../../../../models/announcement_model.dart';
import 'detail_announcement_volunteer.dart';

class ItemAnnouncementVolunteer extends StatelessWidget {
  final Announcement announcement;
  bool? isSelected;
  VoidCallback? toggleFavorite;

  ItemAnnouncementVolunteer({super.key,
    required this.announcement,
      this.isSelected,
      this.toggleFavorite});

  ImageProvider _getImageProvider(String? imageString) {
    if (imageString == null) {
      return AssetImage('assets/logo.png');
    }
    if (isBase64(imageString)) {
      return MemoryImage(base64.decode(imageString));
    } else {
      return NetworkImage(imageString);
    }
  }

  bool isBase64(String str) {
    try {
      base64.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAnnouncementVolunteer(),
          ),
        );
      },
      child: Container(
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
                          backgroundImage:
                          _getImageProvider(announcement.image),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              announcement.nameAssociation,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ManageDate.describeRelativeDateTime(
                                  announcement.datePublication),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: toggleFavorite,
                      icon: isSelected!
                          ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                          : Icon(
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
                        InformationAnnouncement(
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
                        InformationAnnouncement(
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
                        InformationAnnouncement(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.black,
                            size: 16,
                          ),
                          text: '${announcement.nbHours} heures',
                          size: 11,
                        ),
                        InformationAnnouncement(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 16,
                          ),
                          text:
                          '${announcement.nbPlacesTaken} / ${announcement
                              .nbPlaces}',
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
      ),
    );
  }
}

