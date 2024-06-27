import 'package:flutter/material.dart';

class DoubleButton extends StatefulWidget {
  const DoubleButton({super.key});

  @override
  State<DoubleButton> createState() => _DoubleButtonState();
}

class _DoubleButtonState extends State<DoubleButton> {
  bool isAddedToList = false;

  void toggleListStatus() {
    setState(() {
      isAddedToList = !isAddedToList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text(
              isAddedToList ? 'Añadida a Favoritos' : 'Eliminado de Favoritos',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow_outlined,
                size: 35,
                color: Colors.black,
              ),
              label: Text(
                'COMENZAR A VER E1',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                fixedSize: Size(160, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
          SizedBox(width: 10), // Espacio entre los botones
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(0),
              color: Colors.transparent,
            ),
            child: IconButton(
              onPressed: toggleListStatus,
              icon: Icon(isAddedToList ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.orange),
              color: Colors.orange,
              iconSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}