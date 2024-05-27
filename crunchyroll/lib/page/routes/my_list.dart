import 'package:flutter/material.dart';

class MyListAnime extends StatefulWidget {
  @override
  _MyListAnimeState createState() => _MyListAnimeState();
}

class _MyListAnimeState extends State<MyListAnime> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Mis listas', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Favoritos',),
            Tab(text: 'Crunchylistas'),
            Tab(text: 'Historial'),
            Tab(text: 'Offline'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cast_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: _tabController,
        children: [
          FavoritosScreen(),
          CrunchylistasScreen(),
          HistorialScreen(),
          OfflineScreen(),
        ],
      ),
    );
  }
}

class FavoritosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Actividad reciente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Sample list count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset('assets/images/one-piece.jpg'), // Replace with local image if needed
                  title: Text('Nombre del Anime', style: TextStyle(color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Comenzar a ver S1 E1', style: TextStyle(color: Colors.grey)),
                      Text('Doblaje: Español, Inglés', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CrunchylistasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Crunchylistas Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class HistorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Historial Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class OfflineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Offline Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}