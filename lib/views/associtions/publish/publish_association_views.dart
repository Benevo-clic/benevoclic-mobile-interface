import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/button.dart';

class PublishAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(""),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Commencons par l'essentiel",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "Une bonne description c'est le meilleur moyen pour que vos futurs bénévoles")
                    ]),
                  ),
                  Expanded(
                    child: Text(""),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "Titre de l'annonce",
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "Description",
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "Nombre de bénévoles",
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "Nombre d'heures",
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "Date et heure de la mission",
            ),
            SizedBox(
              height: 15,
            ),
            Item(
              content: "La localisation de la mission",
            ),
            SizedBox(
              height: 35,
            ),
            Button(
              backgroundColor: Colors.grey,
              color: Colors.black,
              text: "Publier",
              fct: () {},
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String content;

  const Item({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbstractContainer3(content: Center(child: Text(content))),
        AbstractContainer4(
          content: TextFormField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            style: TextStyle( decorationColor: orange),
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
