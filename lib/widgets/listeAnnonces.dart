import 'package:flutter/material.dart';
import 'package:namer_app/widgets/fiche_annonce.dart';

class ListeAnnonces extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background2.png"), fit: BoxFit.cover)),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Annonce(),
          Text("oui"),
          Text("oui"),
          Text("oui"),
          Text("oui"),
          Text("oui"),
        ],
      ),
    );
  }
}
