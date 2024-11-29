import 'package:crunchyroll/page/database/database_helper.dart';
import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/routes/anime_detail_page.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatefulWidget {
  final Future<Iterable<Anime>> futureAnimes;

  const Recommendations({super.key, required this.futureAnimes});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Estado para controlar los favoritos
  late Set<int> favoriteIds;

  @override
  void initState() {
    super.initState();
    favoriteIds = {};
    _loadFavorites();
  }

  // Carga los IDs de favoritos desde la base de datos
  Future<void> _loadFavorites() async {
    final favorites = await dbHelper.getFavorites();
    setState(() {
      favoriteIds = favorites.map((anime) => anime.id).toSet();
    });
  }

  // Añade un anime a favoritos y actualiza la lista
  Future<void> _addToFavorites(Anime anime) async {
    final result = await dbHelper.addFavorite(anime);

    if (result == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${anime.title} ya está en favoritos.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${anime.title} agregado a favoritos.')),
      );
      setState(() {
        favoriteIds.add(anime.id); // Actualiza la lista de favoritos
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Anime>>(
      future: widget.futureAnimes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Container(
            height: 279,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.map((anime) {
                final isFavorite = favoriteIds.contains(anime.id);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailPage(
                          animeName: anime.title,
                          animeImageUrl: anime.imageUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child:
                              Image.network(anime.imageUrl, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          anime.title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dob | Sub',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert,
                                  color: Colors.grey),
                              onSelected: (value) async {
                                if (value == 'add_favorite') {
                                  final result =
                                      await dbHelper.addFavorite(anime);
                                  final message = result == -1
                                      ? '${anime.title} ya está en favoritos.'
                                      : '${anime.title} agregado a favoritos.';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } else if (value == 'watch_now') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnimeDetailPage(
                                        animeName: anime.title,
                                        animeImageUrl: anime.imageUrl,
                                      ),
                                    ),
                                  );
                                } else if (value == 'share') {
                                  // Lógica para compartir
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Compartir no implementado.')),
                                  );
                                } else if (value == 'mark_seen') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Marcado como visto.')),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'add_favorite',
                                  child: Text('Añadir a favoritos'),
                                ),
                                const PopupMenuItem(
                                  value: 'watch_now',
                                  child: Text('Ver ahora'),
                                ),
                                const PopupMenuItem(
                                  value: 'share',
                                  child: Text('Compartir'),
                                ),
                                const PopupMenuItem(
                                  value: 'mark_seen',
                                  child: Text('Marcar como visto'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return const Center(child: Text('No hay animes disponibles'));
        }
      },
    );
  }
}
