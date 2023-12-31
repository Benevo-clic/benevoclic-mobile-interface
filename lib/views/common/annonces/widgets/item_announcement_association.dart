import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/page/page_cubit.dart';
import 'package:namer_app/views/common/annonces/widgets/detail_announcement_association.dart';

import '../../../../cubit/announcement/announcement_cubit.dart';
import '../../../../models/announcement_model.dart';
import '../../../../util/manage_date.dart';
import '../../../../widgets/information_announcement.dart';

class ItemAnnouncementAssociation extends StatelessWidget {
  final Announcement announcement;

  ItemAnnouncementAssociation({super.key, required this.announcement});

  late bool isVisible;
  late bool full;

  ImageProvider _getImageProvider(String? imageString) {
    if (isBase64(imageString)) {
      return MemoryImage(base64.decode(imageString!));
    } else {
      return NetworkImage(imageString!);
    }
  }

  bool isBase64(String? str) {
    if (str == null) return false;
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
    String? imageProfileAssociation = announcement.imageProfileAssociation ??
        'https://via.placeholder.com/150';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAnnouncementAssociation(),
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
          color: !announcement.isVisible! || announcement.full!
              ? Colors.grey[700]
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
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
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: Icon(
                          Icons.more_horiz,
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
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(255, 153, 85, 1),
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              String id = announcement.id!;
                              BlocProvider.of<AnnouncementCubit>(context)
                                  .deleteAnnouncement(id);
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Supprimer l'annonce")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<PageCubit>(context).setPage(1);
                              BlocProvider.of<AnnouncementCubit>(context)
                                  .setAnnouncementUpdating(announcement);
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Modifier l'annonce")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              String id = announcement.id!;
                              bool isVisible = announcement.isVisible!;
                              BlocProvider.of<AnnouncementCubit>(context)
                                  .hiddenAnnouncement(id, !isVisible);
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text("Masquer l'annonce")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        );
      },
    );
  }
}

