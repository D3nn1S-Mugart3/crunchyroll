import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/routes/anime_detail_page.dart';
import 'package:flutter/material.dart';


class MusicVideo extends StatelessWidget {
  const MusicVideo({
    super.key,
    required Future<Iterable<Anime>> futurePopularAnimes,
  }) : _futurePopularAnimes = futurePopularAnimes;

  final Future<Iterable<Anime>> _futurePopularAnimes;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Iterable<Anime>>(
      future: _futurePopularAnimes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            height: 180,
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
                    margin: EdgeInsets.only(right: 7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 200,
                          child: Image.network(anime.imageUrl, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 5),
                        Text(
                          anime.title,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'J-Pop', style: TextStyle(fontSize: 14, color: Colors.grey),
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
        }
      },
    );
  }
}