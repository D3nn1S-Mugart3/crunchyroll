import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimulcastsScreen extends StatefulWidget {
  const SimulcastsScreen({super.key});

  @override
  _SimulcastsScreenState createState() => _SimulcastsScreenState();
}

class _SimulcastsScreenState extends State<SimulcastsScreen> {
  String selectedSeason = 'spring'; // Temporada seleccionada por defecto
  Future<List<Anime>>?
      animeList; // Lista futura de animes basadas en la temporada seleccionada

  @override
  void initState() {
    super.initState();
    animeList = fetchSeasonalAnimes(selectedSeason); // Cargar animes al iniciar
  }

  // Función para mostrar la pantalla de selección de temporadas
  void _showSeasonsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeasonsScreen(
          selectedSeason: selectedSeason,
          onSelectSeason: (season) {
            setState(() {
              selectedSeason = season; // Actualizar la temporada seleccionada
              animeList = fetchSeasonalAnimes(
                  selectedSeason); // Actualizar la lista de animes
            });
            Navigator.pop(context); // Cerrar la pantalla de selección
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Temporada de Simulcasts',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cast_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showSeasonsScreen();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_drop_down_sharp,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        selectedSeason,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Anime>>(
              future: animeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.56,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final anime = snapshot.data![index];
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
                        child: AnimeCard(anime: anime),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SeasonsScreen extends StatelessWidget {
  final String selectedSeason;
  final ValueChanged<String> onSelectSeason;

  SeasonsScreen(
      {super.key, required this.selectedSeason, required this.onSelectSeason});

  final List<String> seasons = ['spring', 'summer', 'fall', 'winter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text('Temporadas', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];
          final isSelected = season == selectedSeason;
          return ListTile(
            title: Text(
              season,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.white,
              ),
            ),
            onTap: () {
              onSelectSeason(season);
            },
          );
        },
      ),
    );
  }
}

class Anime {
  final String imageUrl;
  final String title;

  Anime({required this.imageUrl, required this.title});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      imageUrl: json['main_picture']['medium'],
      title: json['title'],
    );
  }
}

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({super.key, required this.anime});

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.white),
                title: const Text('Añadir a favoritos',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implementar lógica de añadir a favoritos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.play_arrow, color: Colors.white),
                title: const Text('Ver ahora',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implementar lógica de ver ahora
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.white),
                title: const Text('Compartir',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Share.share('Mira este anime: ${anime.title}');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.check, color: Colors.white),
                title: const Text('Marcar como visto',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implementar lógica de marcar como visto
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.cover,
              width: 160,
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
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dubbing/Sub',
                        style: TextStyle(color: Colors.grey)),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                      onPressed: () => _showOptionsModal(context),
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

class AnimeDetailPage extends StatelessWidget {
  final String animeName;
  final String animeImageUrl;

  AnimeDetailPage({
    super.key,
    required this.animeName,
    required this.animeImageUrl,
  });

  final String seriesInfo = "Series ";
  final String seriesInfoDob = "• Dob | Sub";
  final String availability =
      "Disponibilidad de subtítulos en Latinoamérica: Domingos a la 1:30 AM PST (Fora del pacifico) ...";
  final String details = "DETALLES DE LA SERIE";
  final String episodeSyncInfo = "Episodios sincronizados";
  final String syncedEpisodes = "5 Episodios";
  final String storageInfo = "1.2 GB";
  final String seasonInfo = "Temporada 1";
  final List<Map<String, String>> episodes = [
    {
      "thumbnail": "assets/images/alicization.png",
      "title": "Capítulo 1",
      "name": "El comienzo"
    },
    {
      "thumbnail": "assets/images/one-piece.jpg",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    {
      "thumbnail": "assets/images/Kimetsu_no_Yaiba-cover.jpg",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    {
      "thumbnail": "assets/images/alicization.png",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    {
      "thumbnail": "assets/images/alicization.png",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    {
      "thumbnail": "assets/images/alicization.png",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    {
      "thumbnail": "assets/images/alicization.png",
      "title": "Capítulo 2",
      "name": "La aventura continúa"
    },
    // Agrega más episodios aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 580.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                animeImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animeName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        seriesInfo,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 33, 243, 236),
                            fontSize: 16),
                      ),
                      Text(
                        seriesInfoDob,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text("AÑADIR A CRUNCHYLISTA",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    availability,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      details,
                      style:
                          const TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        episodeSyncInfo,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "$syncedEpisodes • $storageInfo",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    seasonInfo,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final episode = episodes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              episode["thumbnail"]!,
                              width: 100,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode["title"]!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  episode["name"]!,
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 14),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.check_circle, color: Colors.green),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Anime>> fetchSeasonalAnimes(String season) async {
  final response = await http.get(
    Uri.parse(
        'https://api.myanimelist.net/v2/anime/season/2024/$season?limit=10'),
    headers: {'X-MAL-CLIENT-ID': 'f4b43c14393b157005dee233e1ea0661'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((anime) => Anime.fromJson(anime['node'])).toList();
  } else {
    throw Exception('Failed to load animes');
  }
}

Future<List<Anime>> searchAnimes(String query) async {
  final response = await http.get(
    Uri.parse('https://api.myanimelist.net/v2/anime?q=$query&limit=10'),
    headers: {'X-MAL-CLIENT-ID': 'f4b43c14393b157005dee233e1ea0661'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((anime) => Anime.fromJson(anime['node'])).toList();
  } else {
    throw Exception('Failed to search animes');
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Anime> _filteredAnimes = [];

  void _searchAnimes() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      searchAnimes(query).then((animes) {
        setState(() {
          _filteredAnimes = animes;
        });
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _filteredAnimes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Buscar...',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
          onChanged: (query) {
            _searchAnimes();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: _filteredAnimes.isEmpty
          ? const Center(
              child: Text('No hay resultados',
                  style: TextStyle(color: Colors.white)))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.56,
              ),
              itemCount: _filteredAnimes.length,
              itemBuilder: (context, index) {
                final anime = _filteredAnimes[index];
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
                  child: AnimeCard(anime: anime),
                );
              },
            ),
    );
  }
}
