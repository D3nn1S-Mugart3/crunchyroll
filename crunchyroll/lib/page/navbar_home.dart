import 'package:crunchyroll/page/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:crunchyroll/page/routes/my_list.dart';
import 'package:crunchyroll/page/routes/profile.dart';
import 'package:crunchyroll/page/routes/simulcasts.dart';
import 'package:flutter/services.dart';

class NavbarHome extends StatefulWidget {
  const NavbarHome({super.key});

  @override
  State<NavbarHome> createState() => _NavbarHomeState();
}

class _NavbarHomeState extends State<NavbarHome> {
  int selectedIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const Home_Page2(),
      MyListAnime(),
      const Text("data"),
      SimulcastsScreen(),
      GradientScrollView(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // Feedback háptico al seleccionar un ítem
      HapticFeedback.lightImpact();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.home_outlined),
                if (selectedIndex == 0)
                  Positioned(
                    bottom: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.bookmark_border),
                if (selectedIndex == 1)
                  Positioned(
                    bottom: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            label: 'Mis listas',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.grid_view_outlined),
                if (selectedIndex == 2)
                  Positioned(
                    bottom: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.auto_awesome_outlined),
                if (selectedIndex == 3)
                  Positioned(
                    bottom: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            label: 'Simulcasts',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.person_outline_outlined),
                if (selectedIndex == 4)
                  Positioned(
                    bottom: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
              ],
            ),
            label: 'Cuenta',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        backgroundColor: const Color.fromARGB(221, 1, 1, 1),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        type: BottomNavigationBarType.fixed, // Ensure consistent label sizes
      ),
    );
  }
}