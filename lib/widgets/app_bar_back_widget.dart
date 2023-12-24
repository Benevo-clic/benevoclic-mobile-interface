import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarBackWidget extends StatelessWidget {
  const AppBarBackWidget({super.key, required this.contexts});

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(contexts);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/arrow-left.svg",
                      color: Colors.white,
                      height: MediaQuery.of(contexts).size.height * .05,
                    ), // Définissez la taille de l'icône
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
