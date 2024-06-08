import 'package:crunchyroll/page/routes/home.dart';
import 'package:crunchyroll/page/routes/my_list.dart';
import 'package:crunchyroll/page/routes/profile.dart';
import 'package:crunchyroll/page/routes/simulcasts.dart';
import 'package:crunchyroll/page/view/home/home.dart';
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
      Home_Page2(),
      MyListAnime(),
      const Text("data"),
      SimulcastsScreen(),
      GradientScrollView()
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
            backgroundColor: Color.fromARGB(221, 1, 1, 1),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            backgroundColor: Color.fromARGB(221, 1, 1, 1),
            label: 'Mis listas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined ),
            backgroundColor: Color.fromARGB(221, 1, 1, 1),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            backgroundColor: Color.fromARGB(221, 1, 1, 1),
            label: 'Simulcasts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            backgroundColor: Color.fromARGB(221, 1, 1, 1),
            label: 'Cuenta',
          ),
        ],
        currentIndex: selecteditems,
        onTap: updateItems,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      ),
      body: Center(
        child: itemLabels[selecteditems],
      ),
    );
  }
}