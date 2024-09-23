import 'package:flutter/material.dart';

class TriggFullScreenImage extends StatelessWidget {
  final imageSource;
  const TriggFullScreenImage({Key? key, this.imageSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageSource,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
