import 'package:flutter/material.dart';

import 'image_picker_profile.dart';

class PictureSignup extends StatelessWidget {
  PictureSignup({super.key});

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).size.height * .009 / 4;

    return Stack(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .35,
          child: Card(
            margin: const EdgeInsets.all(5),
            shadowColor: Colors.grey,
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Color.fromRGBO(235, 126, 26, 1))),
            color: Colors.white.withOpacity(0.8),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: MyImagePicker(),
            ),
          ),
        )
      ],
    );
  }
}
