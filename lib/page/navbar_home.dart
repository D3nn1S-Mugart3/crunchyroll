import 'package:crunchyroll/page/routes/favorites_page.dart';
import 'package:crunchyroll/page/routes/home.dart';
import 'package:crunchyroll/page/routes/mangas_pdf.dart';
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

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // Feedback háptico al seleccionar un ítem
      HapticFeedback.lightImpact();
    });
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return MyListAnime();
      case 2:
        return const FavoritesPage(); // Reconstruye cada vez que cambie
      case 3:
        return MangasPDF();
      case 4:
        return SimulcastsScreen();
      case 5:
        return GradientScrollView();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedPage(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.home_outlined, selectedIndex == 0),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.bookmark_border, selectedIndex == 1),
            label: 'Mis listas',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.grid_view_outlined, selectedIndex == 2),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.menu_book_rounded, selectedIndex == 3),
            label: 'Mangas',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.bookmark_border, selectedIndex == 4),
            label: 'Simulcasts',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(
                Icons.person_outline_outlined, selectedIndex == 5),
            label: 'Cuenta',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        backgroundColor: Colors.grey[800],
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        type: BottomNavigationBarType.fixed, // Ensure consistent label sizes
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Stack(
      children: [
        Icon(icon),
        if (isSelected)
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
    );
  }
}
