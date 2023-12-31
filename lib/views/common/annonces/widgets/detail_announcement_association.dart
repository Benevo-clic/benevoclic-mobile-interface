import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:namer_app/models/announcement_model.dart';

import '../../../../models/location_model.dart';

class DetailAnnouncementAssociation extends StatelessWidget {
  Announcement announcement = Announcement(
      idAssociation: "id",
      dateEvent: "12/12/2021 12:00",
      datePublication: "datePublication",
      description:
          "dans ccompagnement de mineurs isolés étrangers, la mise à l'abri de femmes seules ou avec enfants afin qu'elles ne dorment pas dehors la nuit. De plus, "
          "il propose une friperie : La boutique solidaire .dans ccompagnement de mineurs isolés étrangers, la mise à l'abri de femmes "
          "seules ou avec enfants afin qu'elles ",
      location: LocationModel(address: "address", latitude: 0, longitude: 0),
      nameAssociation: "nameAssociation",
      labelEvent: "Distribution alimentaire",
      image: "image",
      imageProfileAssociation: "imageProfileAssociation",
      nbHours: 2,
      nbPlaces: 2,
      nbPlacesTaken: 2,
      type: "type");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
          infoAsso(context),
          infoAddress(context),
        ]),
      ),
    );
  }

  Widget infosMission(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      height: 85,
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
                    announcement.labelEvent!,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    announcement.dateEvent!,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/pencil.svg",
                    height: height * .02,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                height: 25,
                width: 150,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.person, size: 15),
                  label: Text(
                    "2/5 bénévoles",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 1),
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
                      "3 rue de la paix, 75000 Paris",
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

  Widget infoAsso(BuildContext context) {
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
                        announcement.nameAssociation,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "38 annonces",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                width: 100,
                child: TextButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(170, 77, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: Text(
                    "Voir mon profil",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
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
            "Dans l'accompagnement de mineurs isolés étrangers, la mise à l'abri de femmes seules ou avec enfants afin qu'elles ne dorment pas dehors la nuit. De plus, "
            "il propose une friperie ...",
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
