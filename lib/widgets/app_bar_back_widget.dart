import 'package:flutter/material.dart';

class AppBarBackWidget extends StatelessWidget {
  const AppBarBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Mes voyages'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
