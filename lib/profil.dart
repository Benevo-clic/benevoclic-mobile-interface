import 'package:flutter/material.dart';

import 'services/auth.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background3.png"), fit: BoxFit.cover)),
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () async {
                  print('init');
                  await AuthService().logout();
                  print("end");
                },
                icon: Icon(Icons.logout),
              ),
            ),
            Expanded(child: Text("Déconnexion")),
            Expanded(child: Text(""))
          ],
        ),
        LineProfil(
            text: "Suppression de compte",
            icon: IconButton(
              onPressed: () async {
                print('init');
                await AuthService().deleteAccount();
                print("end");
              },
              icon: Icon(Icons.access_alarm_sharp),
            ))
      ]),
    );
  }
}

class LineProfil extends StatelessWidget {
  final text;
  final icon;

  const LineProfil({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            onPressed: () async {
              print('init');
              await AuthService().logout();
              print("end");
            },
            icon: this.icon,
          ),
        ),
        Expanded(child: Text(this.text)),
        Expanded(child: Text(""))
      ],
    );
  }
}
