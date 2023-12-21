import 'package:flutter/material.dart';

class PictureWidget extends StatelessWidget {
  final double? radius;
  final String image;
  final double? size;

  const PictureWidget(
      {super.key, required this.radius, required this.image, this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      foregroundImage: NetworkImage(image),
      child: Icon(
        Icons.person,
        color: Colors.black,
        size: size,
      ),
    );
  }
}
