import 'package:flutter/material.dart';
import 'package:namer_app/views/common/authentification/repository/auth_repository.dart';
import 'package:namer_app/views/common/authentification/signup/association/infos_inscription.dart';

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
              if (AuthRepository().verifiedEmail() == true) {
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
