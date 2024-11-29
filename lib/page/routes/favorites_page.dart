import 'package:flutter/material.dart';
import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/database/database_helper.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Anime>> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = DatabaseHelper().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Anime>>(
        future: _favorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final anime = snapshot.data![index];
                return ListTile(
                  leading: Image.network(anime.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(anime.title,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    anime.synopsis,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DatabaseHelper().removeFavorite(anime.id);
                      setState(() {
                        _favorites = DatabaseHelper().getFavorites();
                      });
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No tienes animes favoritos.'));
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
