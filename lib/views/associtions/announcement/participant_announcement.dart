import 'package:flutter/material.dart';

class ParticipantAnnouncement extends StatelessWidget {
  const ParticipantAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonces'),
      ),
      body: Center(
        child: Text('Annonces'),
      ),
    );
  }
}
