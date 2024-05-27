import 'package:flutter/material.dart';

class SimulcastsScreen extends StatefulWidget {
  @override
  _SimulcastsScreenState createState() => _SimulcastsScreenState();
}

class _SimulcastsScreenState extends State<SimulcastsScreen> {
  String selectedSeason = 'Primavera 2024';
  bool isSeasonsVisible = true;

  void _showSeasonsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeasonsScreen(
          selectedSeason: selectedSeason,
          onSelectSeason: (season) {
            setState(() {
              selectedSeason = season;
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
      body: SingleChildScrollView(
        child: Column(
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
            AnimeList(),
          ],
        ),
      ),
    );
  }
}

class SeasonsScreen extends StatelessWidget {
  final String selectedSeason;
  final ValueChanged<String> onSelectSeason;

  SeasonsScreen({required this.selectedSeason, required this.onSelectSeason});

  final List<String> seasons = [
    'Primavera 2024',
    'Verano 2024',
    'Otoño 2024',
    'Invierno 2024',
  ];

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
            Text('Temporadas', style: TextStyle(color: Colors.white),),
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
  final String name;
  final String dubbing;

  Anime({required this.imageUrl, required this.name, required this.dubbing});
}

class AnimeList extends StatelessWidget {
  final List<Anime> animes = [
    Anime(imageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg', name: 'Kimetsu no Yaiba', dubbing: 'Dob | Sub'),
    Anime(imageUrl: 'assets/images/haikyuu.png', name: 'Anime 2', dubbing: 'Subtitulado'),
    Anime(imageUrl: 'assets/images/alicization.png', name: 'Anime 3', dubbing: 'Dob English | Sub'),
    Anime(imageUrl: 'assets/images/one-piece.jpg', name: 'One Piece', dubbing: 'Dob | Sub'),
    Anime(imageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg', name: 'Anime 5', dubbing: 'Dob | Sub'),
    Anime(imageUrl: 'assets/images/alicization.png', name: 'Anime 6', dubbing: 'Subtitulado'),
    Anime(imageUrl: 'assets/images/haikyuu.png', name: 'Anime 7', dubbing: 'Dob English | Sub'),
    Anime(imageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg', name: 'Anime 8', dubbing: 'Doblado en Ingles'),
    Anime(imageUrl: 'assets/images/one-piece.jpg', name: 'Anime 9', dubbing: 'Dob | Sub'),
    Anime(imageUrl: 'assets/images/one-piece.jpg', name: 'Anime 10', dubbing: 'Subtitulado'),
    Anime(imageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg', name: 'Anime 11', dubbing: 'Dob English | Sub'),
    Anime(imageUrl: 'assets/images/alicization.png', name: 'Anime 12', dubbing: 'Doblado en Ingles'),
    Anime(imageUrl: 'assets/images/haikyuu.png', name: 'Anime 13', dubbing: 'Dob | Sub'),
    Anime(imageUrl: 'assets/images/one-piece.jpg', name: 'Anime 14', dubbing: 'Subtitulado'),
    Anime(imageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg', name: 'Anime 15', dubbing: 'Dob English | Sub'),
    Anime(imageUrl: 'assets/images/alicization.png', name: 'Anime 16', dubbing: 'Doblado en Ingles'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.56,
      ),
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime = animes[index];
        return AnimeCard(anime: anime);
      },
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
          Image.asset(
            anime.imageUrl,
            fit: BoxFit.cover,
            height: 269,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(anime.dubbing, style: TextStyle(color: Colors.grey),),
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