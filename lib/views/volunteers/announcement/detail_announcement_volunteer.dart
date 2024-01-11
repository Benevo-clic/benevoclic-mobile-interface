import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/cubit/announcement/announcement_state.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/repositories/api/association_repository.dart';
import 'package:namer_app/views/volunteers/profil/association_profil.dart';
import 'package:namer_app/widgets/info_adress_detail_announcement.dart';

import '../../../cubit/announcement/announcement_cubit.dart';
import '../../../cubit/volunteer/volunteer_cubit.dart';
import '../../../util/color.dart';
import '../../../widgets/information_announcement.dart';
import '../../common/annonces/googleMap/google_map_widget.dart';
import 'contact_me_widget.dart';

class DetailAnnouncementVolunteer extends StatefulWidget {
  Announcement announcement;
  int? nbAnnouncementsAssociation;
  String? idVolunteer;
  VoidCallback? toggleFollow;

  DetailAnnouncementVolunteer(
      {super.key,
      required this.announcement,
      this.nbAnnouncementsAssociation,
      this.idVolunteer,
      this.toggleFollow});

  @override
  State<DetailAnnouncementVolunteer> createState() =>
      _DetailAnnouncementVolunteerState();
}

class _DetailAnnouncementVolunteerState
    extends State<DetailAnnouncementVolunteer> {
  AssociationRepository _associationRepository = AssociationRepository();
  late bool isWaiting = false;
  late bool isParticipate = false;

  @override
  void initState() {
    super.initState();
    if (widget.announcement.volunteers != null && widget.idVolunteer != null) {
      isParticipate = widget.announcement.volunteers!
          .map((e) => e.id)
          .toList()
          .contains(widget.idVolunteer);
    }
    if (widget.announcement.volunteersWaiting != null &&
        widget.idVolunteer != null) {
      isWaiting = widget.announcement.volunteersWaiting!
          .map((e) => e.id)
          .toList()
          .contains(widget.idVolunteer);
    }
    BlocProvider.of<AnnouncementCubit>(context)
        .changeState(AnnouncementInitialState());
  }

  Future<Association> getAssociation() async {
    await Future.delayed(Duration(milliseconds: 500));

    Association? association = await _associationRepository
        .getAssociation(widget.announcement.idAssociation);

    return association;
  }

  void _toggleFollowAssociation(Association association) async {
    if (widget.idVolunteer == null) {
      return;
    }
    bool isFollow = association.volunteers!
        .map((e) => e.id)
        .toList()
        .contains(widget.idVolunteer);
    if (isFollow) {
      BlocProvider.of<VolunteerCubit>(context)
          .unfollowAssociation(widget.announcement.idAssociation);
    } else {
      BlocProvider.of<VolunteerCubit>(context)
          .followAssociation(widget.announcement.idAssociation);
    }
  }

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

  void _processAnnouncements(Announcement announcement) {
    if (widget.idVolunteer == null) {
      return;
    }
    isParticipate = announcement.volunteers!
        .map((e) => e.id)
        .toList()
        .contains(widget.idVolunteer);
    isWaiting = announcement.volunteersWaiting!
        .map((e) => e.id)
        .toList()
        .contains(widget.idVolunteer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementCubit, AnnouncementState>(
      listener: (context, state) {
        if (state is AnnouncementRemovedParticipateState) {
          widget.announcement = state.announcement;
          _processAnnouncements(state.announcement);
        }
        if (state is AnnouncementAddedParticipateState) {
          widget.announcement = state.announcement;
          _processAnnouncements(state.announcement);
        }
        if (state is AnnouncementErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackBar snackBar =
                SnackBar(content: Text("Erreur lors de l'ajout"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        if (state is AnnouncementRemovedWaitingState) {
          widget.announcement = state.announcement;
          _processAnnouncements(state.announcement);
        }
        if (state is AnnouncementAddedWaitingState) {
          widget.announcement = state.announcement;
          _processAnnouncements(state.announcement);
        }
      },
      builder: (context, state) {
        return FutureBuilder<Association>(
          future: getAssociation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : marron,
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Erreur lors du chargement des annonces'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Association introuvable'));
            }
            final association = snapshot.data!;
            return _buildAnnouncementDetail(context, association);
          },
        );
      },
    );
  }

  Widget _buildAnnouncementDetail(
      BuildContext context, Association association) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft, // Adjust the alignment as needed
              children: [
                widget.announcement.image != null &&
                        widget.announcement.image !=
                            "https://via.placeholder.com/150"
                    ? Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(
                                  base64.decode(widget.announcement.image!)),
                              // NetworkImage(announcement.image!),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage("https://via.placeholder.com/150"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                Positioned(
                  top: height * 0.05,
                  left: width * 0.03,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/cancel.svg",
                      height: height * .04,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            infosMission(context, association),
            bio(context),
            SizedBox(
              height: 5,
            ),
            infoAsso(context, association),
            InfoAdressAnnouncement(
              latitude: widget.announcement.location.latitude,
              longitude: widget.announcement.location.longitude,
              address: widget.announcement.location.address,
            ),
          ],
        ),
      ),
    );
  }

  Widget infosMission(BuildContext context, Association association) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 100,
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
          border: Border.all(color: Colors.red, width: 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.announcement.labelEvent!,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    widget.announcement.dateEvent!,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
              InformationAnnouncement(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 24,
                ),
                text:
                    '${widget.announcement.nbPlacesTaken} / ${widget.announcement.nbPlaces}',
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 25,
                  width: 150,
                  child: ContactAssociationWidget(
                    phoneNumber: association.phone,
                    email: association.email,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              if (widget.announcement.full! && !isParticipate)
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Text(
                        "Complet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              if (isWaiting)
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AnnouncementCubit>(context)
                            .removeVolunteerFromWaitingList(
                                widget.announcement.id!, widget.idVolunteer!);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Text(
                        "En attente",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              if (isParticipate)
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AnnouncementCubit>(context)
                            .unregisterAnnouncement(
                                widget.announcement.id!, widget.idVolunteer!);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Text(
                        "Annuler participation",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              if (!isParticipate && !widget.announcement.full! && !isWaiting)
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AnnouncementCubit>(context)
                            .addVolunteerToWaitingList(
                                widget.idVolunteer!, widget.announcement.id!);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(170, 77, 79, 1),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Text(
                        "Participer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoAddress(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width * 1,
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
          border: Border.all(color: Colors.red, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.black,
                    ),
                    label: Text(
                      widget.announcement.location.address,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06),
                    child: GoogleMapView(
                      latitude: widget.announcement.location.latitude,
                      longitude: widget.announcement.location.longitude,
                      address: widget.announcement.location.address,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget infoAsso(BuildContext context, Association association) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 80,
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
          border: Border.all(color: Colors.red, width: 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssociationProfil(
                                    association: association,
                                    nbAnnouncement:
                                        widget.nbAnnouncementsAssociation,
                                  )));
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: _getImageProvider(
                          widget.announcement.imageProfileAssociation),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.announcement.nameAssociation,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.nbAnnouncementsAssociation} annonces",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: ,
              // ),

              // if (!association.volunteersWaiting!
              //         .map((e) => e.id)
              //         .toList()
              //         .contains(widget.idVolunteer) &&
              //     !association.volunteers!
              //         .map((e) => e.id)
              //         .toList()
              //         .contains(widget.idVolunteer))
              //   ElevatedButton.icon(
              //     onPressed: () {
              //       // _toggleFollowAssociation(association);
              //       PopDialog(
              //           content: Text(
              //               "Cette fonctionnalité sera disponible prochainement. Restez à l\'écoute!"));
              //     },
              //     icon: Icon(Icons.back_hand, size: 15),
              //     label: Text(
              //       "Adhérer",
              //       style: TextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         side: BorderSide(color: Colors.black, width: 1),
              //       ),
              //     ),
              //   ),
              //
              // if (!association.volunteers!
              //         .map((e) => e.id)
              //         .toList()
              //         .contains(widget.idVolunteer) &&
              //     association.volunteersWaiting!
              //         .map((e) => e.id)
              //         .toList()
              //         .contains(widget.idVolunteer))
              //   ElevatedButton.icon(
              //     onPressed: () {
              //       _toggleFollowAssociation(association);
              //     },
              //     icon: Icon(Icons.back_hand, size: 15),
              //     label: Text(
              //       "En attente",
              //       style: TextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         side: BorderSide(color: Colors.black, width: 1),
              //       ),
              //     ),
              //   ),
              // if (association.volunteers!
              //     .map((e) => e.id)
              //     .toList()
              //     .contains(widget.idVolunteer))
              //   ElevatedButton.icon(
              //     onPressed: () {
              //       _toggleFollowAssociation(association);
              //     },
              //     icon: Icon(Icons.back_hand, size: 15),
              //     label: Text(
              //       "Se désinscrire",
              //       style: TextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //         side: BorderSide(color: Colors.black, width: 1),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bio(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width * 1,
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
          border: Border.all(color: Colors.red, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            widget.announcement.description,
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

// Widget
}
