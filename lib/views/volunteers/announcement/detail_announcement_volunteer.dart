import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/association_model.dart';
import 'package:namer_app/repositories/api/association_repository.dart';

import '../../../cubit/volunteer/volunteer_cubit.dart';
import '../../../widgets/information_announcement.dart';

class DetailAnnouncementVolunteer extends StatefulWidget {
  Announcement announcement;
  int? nbAnnouncementsAssociation;
  String? idVolunteer;
  VoidCallback? toggleParticipant;
  bool? isParticipate;
  VoidCallback? toggleFollow;

  DetailAnnouncementVolunteer(
      {super.key,
      required this.announcement,
      this.nbAnnouncementsAssociation,
      this.isParticipate,
      this.idVolunteer,
      this.toggleParticipant,
      this.toggleFollow});

  @override
  State<DetailAnnouncementVolunteer> createState() =>
      _DetailAnnouncementVolunteerState();
}

class _DetailAnnouncementVolunteerState
    extends State<DetailAnnouncementVolunteer> {
  AssociationRepository _associationRepository = AssociationRepository();

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

    if (mounted) {
      setState(() {
        isFollow = association.volunteers!
            .map((e) => e.id)
            .toList()
            .contains(widget.idVolunteer);
      });
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
    double height = MediaQuery.sizeOf(context).height;
    return FutureBuilder<Association>(
      future: getAssociation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur lors du chargement des annonces'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('Association introuvable'));
        }
        final association = snapshot.data!;
        print(association.volunteersWaiting!
            .map((e) => e.id)
            .toList()
            .contains(widget.idVolunteer));
        return _buildAnnouncementDetail(context, association);
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
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/annonce.png"),
                        // NetworkImage(announcement.image!),
                        fit: BoxFit.cover),
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
            infosMission(context),
            bio(context),
            SizedBox(
              height: 5,
            ),
            infoAsso(context, association),
            infoAddress(context),
          ],
        ),
      ),
    );
  }

  Widget infosMission(BuildContext context) {
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
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromRGBO(235, 126, 26, 1),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Text(
                      "Nous contacter",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              if (widget.announcement.full! && !widget.isParticipate!)
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
              if (widget.announcement.volunteersWaiting!
                  .map((e) => e.id)
                  .toList()
                  .contains(widget.idVolunteer))
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        widget.toggleParticipant!();
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
              if (widget.isParticipate!)
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        widget.toggleParticipant!();
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
              if (!widget.isParticipate! &&
                  !widget.announcement.full! &&
                  !widget.announcement.volunteersWaiting!
                      .map((e) => e.id)
                      .toList()
                      .contains(widget.idVolunteer))
                Expanded(
                  child: SizedBox(
                    height: 25,
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        widget.toggleParticipant!();
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
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      size: 15,
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
                  )
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
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/logo.png'),
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

              if (!association.volunteersWaiting!
                      .map((e) => e.id)
                      .toList()
                      .contains(widget.idVolunteer) &&
                  !association.volunteers!
                      .map((e) => e.id)
                      .toList()
                      .contains(widget.idVolunteer))
                ElevatedButton.icon(
                  onPressed: () {
                    _toggleFollowAssociation(association);
                  },
                  icon: Icon(Icons.back_hand, size: 15),
                  label: Text(
                    "Adhérer",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),

              if (!association.volunteers!
                      .map((e) => e.id)
                      .toList()
                      .contains(widget.idVolunteer) &&
                  association.volunteersWaiting!
                      .map((e) => e.id)
                      .toList()
                      .contains(widget.idVolunteer))
                ElevatedButton.icon(
                  onPressed: () {
                    _toggleFollowAssociation(association);
                  },
                  icon: Icon(Icons.back_hand, size: 15),
                  label: Text(
                    "En attente",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              if (association.volunteers!
                  .map((e) => e.id)
                  .toList()
                  .contains(widget.idVolunteer))
                ElevatedButton.icon(
                  onPressed: () {
                    _toggleFollowAssociation(association);
                  },
                  icon: Icon(Icons.back_hand, size: 15),
                  label: Text(
                    "Se désinscrire",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
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

//
// a(int b) {
//   print(b);
// }
//
// class Bio extends StatelessWidget {
//   final String text;
//
//   Bio({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.all(15),
//         width: MediaQuery.sizeOf(context).width * 0.85,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: orange, width: 2)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [Text("Bio"), SizedBox(height: 5), Text(text)],
//         ));
//   }
// }
//
// class Asso extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AbstractContainer(
//         content: Row(
//       children: [
//         Expanded(
//           child: Image.asset(
//             "assets/logo.png",
//             height: 80,
//           ),
//         ),
//         Expanded(child: Text("Nom asso")),
//         Expanded(
//           child: Button(
//               backgroundColor: Colors.green,
//               color: Colors.white,
//               fct: () => {},
//               text: "Adhérer"),
//         )
//       ],
//     ));
//   }
// }
