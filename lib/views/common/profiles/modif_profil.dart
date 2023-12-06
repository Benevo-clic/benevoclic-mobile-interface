import 'package:flutter/material.dart';
import 'package:namer_app/util/color.dart';
import 'package:namer_app/widgets/abstract_container.dart';
import 'package:namer_app/widgets/button.dart';

class ModifProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Photo(),
            BioModif(text: "fcefefef"),
            SizedBox(
              height: 15,
            ),
            InformationsModif(),
            SizedBox(
              height: 15,
            ),
            Button(
                text: "Enregistrer",
                color: Colors.white,
                fct: () => {},
                backgroundColor: orange)
          ],
        ),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Photo de profil");
  }
}

class BioModif extends StatelessWidget {
  final String text;

  BioModif({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Text("Bio"), SizedBox(height: 5), Text(text)],
    ));
  }
}

class InformationsModif extends StatelessWidget {
  InformationsModif({super.key});

  @override
  Widget build(BuildContext context) {
    return AbstractContainer(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Section(
          text: "3 rue du general Leclrece",
          icon: Icon(Icons.maps_home_work_outlined),
        ),
        SizedBox(
          height: 15,
        ),
        Section(
          text: "+33062548",
          icon: Icon(Icons.phone),
        ),
        SizedBox(
          height: 15,
        ),
        Section(
          text: "monsite@gmail.com",
          icon: Icon(Icons.mail),
        )
      ],
    ));
  }
}

class Section extends StatelessWidget {
  final String text;
  final Icon icon;

  Section({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: orange))),
        child: Row(
          children: [
            Expanded(flex: 0, child: icon),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
            ),
          ],
        ));
  }
}
