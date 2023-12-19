import 'package:flutter/material.dart';

class AppBarAnnouncementWidget extends StatelessWidget {
  const AppBarAnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mes annonces'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
