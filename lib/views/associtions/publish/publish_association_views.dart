import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/views/associtions/publish/widget/publish_item.dart';
import 'package:namer_app/widgets/button.dart';

import 'widget/publish_item2.dart';

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
            PublishItem(
              content: "Titre de l'annonce",
            ),
            SizedBox(
              height: 15,
            ),
            PublishItem(
              content: "Description",
            ),
            SizedBox(
              height: 15,
            ),
            PublishItem(
              content: "Nombre de bénévoles",
            ),
            SizedBox(
              height: 15,
            ),
            PublishItem(
              content: "Nombre d'heures",
            ),
            SizedBox(
              height: 15,
            ),
            PublishItem(
              content: "Date et heure de la mission",
            ),
            SizedBox(
              height: 15,
            ),
            PublishItem(
              content: "La localisation de la mission",
            ),
            SizedBox(
              height: 35,
            ),
            PublishItem2(content: "Date "),
            SizedBox(
              height: 15,
            ),
            Button(
                text: "Publier",
                color: Colors.black,
                fct: () {},
                backgroundColor: Colors.grey),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
