import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  const CircleImage(
      {required this.imageProvider, this.imageRadius = 30, Key? key})
      : super(key: key);

  final double imageRadius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
