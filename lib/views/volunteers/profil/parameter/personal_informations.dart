import 'package:flutter/material.dart';
import 'package:namer_app/models/volunteer_model.dart';
import 'package:namer_app/widgets/button.dart';
import 'package:namer_app/widgets/title_with_icon.dart';

import '../../../../util/color.dart';

class InformationDialog extends StatelessWidget {
  final Volunteer volunteer;

  InformationDialog({super.key, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWithIcon(
              title: "Informations personnelles",
              icon: Icon(Icons.perm_identity),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: volunteer.lastName,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: volunteer.firstName,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: volunteer.birthDayDate,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date de naissance',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: volunteer.phone,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Téléphone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: volunteer.location!.address,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Adresse',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Button(
                text: "Modifier",
                color: Colors.white,
                backgroundColor: marron,
                fct: () {
                  // Logique de redirection vers la page de modification
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
