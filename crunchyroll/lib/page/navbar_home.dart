import 'package:crunchyroll/page/routes/home.dart';
import 'package:flutter/material.dart';

class NavbarHome extends StatefulWidget {
  const NavbarHome({super.key});

  @override
  State<NavbarHome> createState() => _BottonNavigationBar();
}

class _BottonNavigationBar extends State<NavbarHome> {
  int selecteditems = 0;
  late List<Widget> itemLabels;

  @override
  void initState() {
    super.initState();
    itemLabels = [
      const HomePage(),
      const Text("data"),
      const Text("data"),
      const Text("data"),
      const Text("data")
    ];
  }

  void updateItems(int value) {
    setState(() {
      selecteditems = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            backgroundColor: Color.fromARGB(255, 46, 45, 45),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            backgroundColor: Color.fromARGB(255, 46, 45, 45),
            label: 'Mis listas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all_rounded),
            backgroundColor: Color.fromARGB(255, 46, 45, 45),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            backgroundColor: Color.fromARGB(255, 46, 45, 45),
            label: 'Simulcasts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            backgroundColor: Color.fromARGB(255, 46, 45, 45),
            label: 'Cuenta',
          ),
        ],
        currentIndex: selecteditems,
        onTap: updateItems,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      ),
      body: Center(
        child: itemLabels[selecteditems],
      ),
    );
  }
}