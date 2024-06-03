import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimulcastsScreen extends StatefulWidget {
  @override
  _SimulcastsScreenState createState() => _SimulcastsScreenState();
}

class _SimulcastsScreenState extends State<SimulcastsScreen> {
  String selectedSeason = 'spring';
  Future<List<Anime>>? animeList;

  @override
  void initState() {
    super.initState();
    animeList = fetchSeasonalAnimes(selectedSeason);
  }

  void _showSeasonsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeasonsScreen(
          selectedSeason: selectedSeason,
          onSelectSeason: (season) {
            setState(() {
              selectedSeason = season;
              animeList = fetchSeasonalAnimes(selectedSeason);
            });
            Navigator.pop(context);
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
        title: Text('Temporada de Simulcasts', style: TextStyle(color: Colors.white, fontSize: 20)),
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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showSeasonsScreen();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_drop_down_sharp, color: Colors.white, size: 24),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      selectedSeason,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Anime>>(
              future: animeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.56,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final anime = snapshot.data![index];
                      return AnimeCard(anime: anime);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SeasonsScreen extends StatelessWidget {
  final String selectedSeason;
  final ValueChanged<String> onSelectSeason;

  SeasonsScreen({required this.selectedSeason, required this.onSelectSeason});

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
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text('Temporadas', style: TextStyle(color: Colors.white)),
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

  AnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dubbing/Sub', style: TextStyle(color: Colors.grey)),
                    Icon(Icons.more_vert, color: Colors.grey),
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

Future<List<Anime>> fetchSeasonalAnimes(String season) async {
  final response = await http.get(
    Uri.parse('https://api.myanimelist.net/v2/anime/season/2024/$season?limit=10'),
    headers: {'X-MAL-CLIENT-ID': 'f4b43c14393b157005dee233e1ea0661'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((anime) => Anime.fromJson(anime['node'])).toList();
  } else {
    throw Exception('Failed to load animes');
  }
}
