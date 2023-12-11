import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/util/get_format_date.dart';
import 'package:namer_app/widgets/abstract_container.dart';

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
          ],
        ),
      ),
    );
  }
}

class PublishItem extends StatelessWidget {
  final String content;

  const PublishItem({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbstractContainer3(content: Center(child: Text(content))),
        AbstractContainer4(
          content: TextFormField(
            decoration: InputDecoration(
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            style: TextStyle(decorationColor: orange),
            cursorColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () async {
        DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 90)));
      },
    );
  }
}

class PublishItem2 extends StatefulWidget {
  final String content;

  const PublishItem2({super.key, required this.content});

  @override
  State<StatefulWidget> createState() {
    return _PublishItem2();
  }
}

class _PublishItem2 extends State<PublishItem2> {
  DateTime? date;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbstractContainer3(content: Center(child: Text(widget.content))),
        AbstractContainer4(
            content: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          readOnly: true,
          onTap: () async {
            DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 90)));
            controller.text = formatDate(pickDate!);
            setState(() {
              date = pickDate;
            });
          },
        ))
      ],
    );
  }
}
