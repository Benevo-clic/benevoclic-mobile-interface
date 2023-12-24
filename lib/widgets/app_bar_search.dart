import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Rechercher'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
    );
  }
}
