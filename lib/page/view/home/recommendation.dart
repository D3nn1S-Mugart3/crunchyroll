import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/routes/anime_detail_page.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({
    super.key,
    required Future<Iterable<Anime>> futureAnimes,
  }) : _futureAnimes = futureAnimes;

  final Future<Iterable<Anime>> _futureAnimes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Anime>>(
      future: _futureAnimes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Container(
            height: 279,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.map((anime) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailPage(
                          animeName: anime.title,
                          animeImageUrl: anime.imageUrl
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          child: Image.network(anime.imageUrl, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 5),
                        Text(
                          anime.title,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dob | Sub', style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert, color: Colors.grey),
                              onPressed: () {
                                // More options
                              },
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
          return Center(child: Text('No hay animes disponibles'));
        }
      },
    );
  }
}