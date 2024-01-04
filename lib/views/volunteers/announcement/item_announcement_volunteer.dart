import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namer_app/util/manage_date.dart';
import 'package:namer_app/widgets/information_announcement.dart';

import '../../../models/announcement_model.dart';
import '../../../models/association_model.dart';
import 'detail_announcement_volunteer.dart';

class ItemAnnouncementVolunteer extends StatefulWidget {
  final Announcement announcement;
  bool? isSelected;
  VoidCallback? toggleFavorite;
  int? nbAnnouncementsAssociation;
  String? idVolunteer;

  ItemAnnouncementVolunteer({super.key,
      required this.announcement,
      this.isSelected,
      this.toggleFavorite,
      this.nbAnnouncementsAssociation,
      this.idVolunteer});

  @override
  State<ItemAnnouncementVolunteer> createState() =>
      _ItemAnnouncementVolunteerState();
}

class _ItemAnnouncementVolunteerState extends State<ItemAnnouncementVolunteer> {
  bool isParticipate = false;
  bool isWaiting = false;
  Association? association;

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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
    String? imageProfileAssociation =
        widget.announcement.imageProfileAssociation ??
            'https://via.placeholder.com/150';

    return InkWell(
      onTap: () {
        if (widget.idVolunteer == null) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAnnouncementVolunteer(
              announcement: widget.announcement,
              nbAnnouncementsAssociation: widget.nbAnnouncementsAssociation,
              idVolunteer: widget.idVolunteer,
            ),
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
          color:
              widget.announcement.full! ? Colors.grey[700] : Colors.grey[100],
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
                              _getImageProvider(imageProfileAssociation),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.announcement.nameAssociation,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ManageDate.describeRelativeDateTime(
                                  widget.announcement.datePublication),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: widget.toggleFavorite,
                      icon: widget.isSelected!
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
                          text: widget.announcement.location.address,
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
                          text: widget.announcement.dateEvent,
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
                          text: '${widget.announcement.nbHours} heures',
                          size: 11,
                        ),
                        InformationAnnouncement(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 16,
                          ),
                          text:
                              '${widget.announcement.nbPlacesTaken} / ${widget.announcement.nbPlaces}',
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.announcement.labelEvent,
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
                  widget.announcement.description,
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

