import 'package:flutter/material.dart';

class Image_profile extends StatelessWidget {
  const Image_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo/cafe-raya.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}