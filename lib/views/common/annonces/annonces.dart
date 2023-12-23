import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container2.dart';

class Annonces extends StatefulWidget {
  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Annonce"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
