import 'dart:io';
import 'package:crunchyroll/page/database/database_helper.dart';
import 'package:crunchyroll/page/models/anime.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key});

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
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
        backgroundColor: Colors.black,
        title: const Text(
          'Mis Favoritos',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Anime>>(
        future: _favorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.56,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final anime = snapshot.data![index];
                return AnimeCard(
                  anime: anime,
                  onRemoveFavorite: () async {
                    await DatabaseHelper().removeFavorite(anime.id);
                    setState(() {
                      _favorites = DatabaseHelper().getFavorites();
                    });
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No tienes animes favoritos.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onRemoveFavorite;

  const AnimeCard(
      {super.key, required this.anime, required this.onRemoveFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: File(anime.imageUrl).existsSync()
                ? Image.file(
                    File(anime.imageUrl),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : const Icon(
                    Icons.broken_image_rounded,
                    size: 50,
                    color: Colors.grey,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Offline',
                      style: TextStyle(color: Colors.grey),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onRemoveFavorite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
