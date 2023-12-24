import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  String? label;

  AppBarWidget({super.key, required this.contexts, this.label});

  final BuildContext contexts;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(contexts).size.width;
    double height = MediaQuery.of(contexts).size.height;
    return Container(
      width: width,
      height: height * .15,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 153, 85, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Ajoutez ceci
                children: [
                  IconButton(
                    onPressed: () {
                      // Action pour le premier bouton
                    },
                    icon: Image.asset(
                      'assets/logo.png',
                      width: width * .1,
                      height: height * .05,
                    ),
                  ),
                  Expanded(
                    // Centre le texte
                    child: Center(
                      child: Text(
                        '$label',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Action pour le deuxième bouton
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
