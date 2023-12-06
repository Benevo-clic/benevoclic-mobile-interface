import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/providers/api/params.dart';
import 'package:namer_app/providers/api/request.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class Annonces extends StatefulWidget {
  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  Future<void> response() async {
    AssoParam p = AssoParam(
        name: "",
        address: "",
        bio: "",
        city: "",
        country: "",
        email: "",
        imageProfile: "",
        phone: "",
        postalCode: "",
        verified: false,
        siret: '',
        ads: [],
        volunteersWaiting: []);

    UserParam p2 = UserParam(
      firstName: "string",
      birthDayDate: "string",
      myAssociations: [],
      lastName: "string",
      myAssociationsWaiting: [],
      address: "string",
      bio: "string",
      city: "string",
      country: "string",
      email: "geoffreyherman1902998@gmail.com",
      imageProfile: "string",
      phone: "string",
      postalCode: "string",
      verified: false,
    );

    Ads p3 = Ads(
        associationId: "string",
        dateEvent: "string",
        datePublication: "string",
        description: "string",
        full: false,
        image: "string",
        location: "string",
        nameAssociation: "string",
        nameEvent: "string",
        nbHours: 5,
        nbPlaces: 10,
        nbPlacesTaken: 2,
        tags: [],
        type: "string",
        volunteers: [],
        volunteersWaiting: []);

    //Response r = await createAds(p3.map());
    Response r = await getAllAds();
    //await connexion();
    //response r2 = await
    //Response r = createAssociation;
    print(r.data);
    setState(() {
      result = r.data;
    });
  }

  List<dynamic> result = [];
  get() async {
    Response r = await getAllAds();
    result = r.data;
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: Container(
                color: orange,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        response();
                      },
                      child: Text("API"),
                    ),
                    Expanded(
                        child: Center(
                            child: Image.asset(
                      "assets/logo.png",
                      height: 70,
                    ))),
                    Expanded(
                        child: Center(
                            child: Container(
                      decoration: BoxDecoration(),
                      child: Text("Search"),
                    ))),
                    Expanded(
                        child: Center(child: Icon(Icons.manage_search_sharp))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.all(20),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (result.isEmpty) {
                      return Text("rien");
                    } else {
                      return ItemAnnonce(
                        nameAsso: result[index]["nameAssociation"],
                        nbHours: result[index]["nbHours"],
                        nbPlaces: result[index]["nbPlaces"],
                        nbPlacesTaken: result[index]["nbPlacesTaken"],
                      );
                    }
                  },separatorBuilder: (BuildContext context, int index) => const Text(""),
              )
            )
          ],
        ),
      ),
    );
  }
}

class ItemAnnonce extends StatelessWidget {
  String nameAsso;
  int nbHours;
  int nbPlaces;
  int nbPlacesTaken;

  ItemAnnonce(
      {required this.nameAsso,
      required this.nbHours,
      required this.nbPlaces,
      required this.nbPlacesTaken});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer2(
        content: Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 0,
                child: Image.asset(
                  "assets/logo.png",
                  height: 50,
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(nameAsso),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  print("favorite");
                },
                color: marron,
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformationAnnonce(
                        icon: Icon(Icons.map),
                        text: "3 rue de tata toto, 59840 Lille"),
                    InformationAnnonce(
                        icon: Icon(Icons.calendar_month),
                        text: "13/10/2024 18:45"),
                    InformationAnnonce(
                        icon: Icon(Icons.hourglass_empty_outlined),
                        text: "$nbHours heures")
                  ],
                )),
            Expanded(child: Text("")),
            Expanded(
                flex: (MediaQuery.sizeOf(context).width * 0.0000001).toInt(),
                child: InformationAnnonce(
                    icon: Icon(Icons.account_circle_outlined),
                    text: "$nbPlacesTaken/$nbPlaces"))
          ],
        ),
        Container(
          decoration: BoxDecoration(
              border:
                  BorderDirectional(bottom: BorderSide(color: Colors.black))),
          child: Text(
            "Distribution alimentaire",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
            "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte.")
      ],
    ));
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
