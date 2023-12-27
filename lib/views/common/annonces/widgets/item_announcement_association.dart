import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/cubit/page/page_cubit.dart';

import '../../../../cubit/announcement/announcement_cubit.dart';
import '../../../../models/announcement_model.dart';
import '../../../../util/manage_date.dart';

class ItemAnnouncementAssociation extends StatefulWidget {
  final Announcement announcement;

  const ItemAnnouncementAssociation({super.key, required this.announcement});

  @override
  State<ItemAnnouncementAssociation> createState() =>
      _ItemAnnouncementAssociationState();
}

class _ItemAnnouncementAssociationState
    extends State<ItemAnnouncementAssociation> {
  late String imageProfileAssociation;

  @override
  void initState() {
    super.initState();
    imageProfileAssociation = widget.announcement.imageProfileAssociation;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                        backgroundImage:
                            Image.memory(base64.decode(imageProfileAssociation))
                                .image,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.announcement.nameAssociation ??
                                'Association',
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
                      InformationAnnonce(
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
                      InformationAnnonce(
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
                      InformationAnnonce(
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 16,
                        ),
                        text: '${widget.announcement.nbHours} heures',
                        size: 11,
                      ),
                      InformationAnnonce(
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
                              String id = widget.announcement.id!;
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
                                  .setAnnouncementUpdating(widget.announcement);
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
