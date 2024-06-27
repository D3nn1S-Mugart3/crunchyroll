import 'package:flutter/material.dart';

class BigImage extends StatelessWidget {
  const BigImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://m.media-amazon.com/images/I/61Zm2hsRJ0L._AC_SY879_.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            'Dob | Sub',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }
}