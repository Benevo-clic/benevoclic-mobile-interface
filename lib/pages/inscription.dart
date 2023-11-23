import 'package:flutter/material.dart';
import 'package:namer_app/pages/infos_inscription.dart';
import 'package:namer_app/services/auth.dart';

class InscriptionDemarche extends StatelessWidget {
  final String adress;
  final String mdp;

  InscriptionDemarche({required this.adress, required this.mdp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
            onPressed: () {
              if (AuthService().verifiedEmail() == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfosInscription()));
              }
            },
            child: Text("J'ai vérifié mon adresse"))
      ],
    ));
  }
}
