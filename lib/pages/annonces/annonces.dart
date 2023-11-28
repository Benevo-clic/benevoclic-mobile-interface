import 'package:flutter/material.dart';
import 'package:namer_app/color/color.dart';
import 'package:namer_app/pages/annonces/detail_annonce.dart';

class Annonces extends StatelessWidget {
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
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetailAnnonce()));
                      },
                      child: ItemAnnonce()),
                  SizedBox(
                    height: 10,
                  ),
                  ItemAnnonce(),
                  SizedBox(
                    height: 10,
                  ),
                  ItemAnnonce(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemAnnonce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: marron, width: 2)),
        child: Column(
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
                      Text("Asso"),
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
                            text: "4 heures")
                      ],
                    )),
                Expanded(child: Text("")),
                Expanded(
                    flex:
                        (MediaQuery.sizeOf(context).width * 0.0000001).toInt(),
                    child: InformationAnnonce(
                        icon: Icon(Icons.account_circle_outlined),
                        text: "10/20"))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.black))),
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
