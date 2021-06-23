import 'dart:io';
import 'package:flutter/material.dart';

class ProfilImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfilImage({this.imagePath, this.onClicked});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Image(
          image: AssetImage(
            'assets/dp.png',
          ),
          height: 150.0,
          width: double.infinity,
        ),
      ),
    );
  }
}
