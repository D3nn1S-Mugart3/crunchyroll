import 'package:crunchyroll/page/routes/anime.dart';
import 'package:crunchyroll/page/routes/video_anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/anime.dart';
import '../services/api_service.dart';
import 'anime_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAddedToList = false;
  late Future<Iterable<Anime>> _futureAnimes;
  late Future<Iterable<Anime>> _futurePopularAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = getAnimeByRankingTypeApi(rankingType: 'all', limit: 10);
    _futurePopularAnimes = getAnimeByRankingTypeApi(rankingType: 'popular', limit: 10);
  }

  void navigateToDetails(Anime anime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimeDetailPage(
          animeName: anime.title,
          animeImageUrl: anime.imageUrl,
        ),
      ),
    );
  }

  void toggleListStatus() {
    setState(() {
      isAddedToList = !isAddedToList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isAddedToList ? 'Se ha añadido a la lista' : 'Se ha eliminado de la lista')
      ),
    );
  }

  void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Marcar como visto'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartir'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  double _scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.black38, 
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.6, 0.7, 0.5],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/crunchyroll.svg',
                color: Colors.orange,
                width: 35,
                height: 35,
              ),
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
        ),
      ),
      backgroundColor: Colors.black,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              _scrollOffset = scrollNotification.metrics.pixels;
            });
          }
          return true;
        },
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimeDetailPage(
                    animeName: 'Kimetsu no Yaiba',
                    animeImageUrl: 'https://m.media-amazon.com/images/I/61Zm2hsRJ0L._AC_SY879_.jpg',
                  )),
                );
              },
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      'assets/images/Kimetsu_no_Yaiba-cover.jpg',
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'Dob | Sub',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimeDetailPage(
                    animeName: 'Kimetsu no Yaiba',
                    animeImageUrl: 'assets/images/Kimetsu_no_Yaiba-cover.jpg',
                  )),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Estamos en la era de Taisho de Japón. Tanjiro, un joven que se gana la vida vendiendo carbón, descubre un día que su familia ha sido asesinada por un demonio...',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {}, 
                  style: ButtonStyle(
                    // backgroundColor: Colors.orange,
                  ),
                  icon: Icon(Icons.play_arrow_outlined, color: Colors.black),
                  label: Text('VER AHORA', style: TextStyle(color: Colors.black),),
                ),
                IconButton(
                  onPressed: toggleListStatus,
                  icon: Icon(isAddedToList ? Icons.bookmark : Icons.bookmark_border, color: Colors.orange,)
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Nuestras recomendaciones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 280,
              child: FutureBuilder<Iterable<Anime>>(
                future: _futureAnimes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No anime found'));
                  } else {
                    final animes = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: animes.length,
                      itemBuilder: (context, index) {
                        final anime = animes.elementAt(index);
                        return GestureDetector(
                          onTap: () => navigateToDetails(anime),
                          child: Container(
                            width: 160,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  anime.imageUrl,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 4),
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
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 8),
            //   child: Text(
            //     'Populares',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            //   ),
            // ),
            // SizedBox(height: 8),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 5),
            //   height: 280,
            //   child: FutureBuilder<Iterable<Anime>>(
            //     future: _futurePopularAnimes,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Center(child: Text('Error: ${snapshot.error}'));
            //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //         return Center(child: Text('No anime found'));
            //       } else {
            //         final animes = snapshot.data!;
            //         return ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           itemCount: animes.length,
            //           itemBuilder: (context, index) {
            //             final anime = animes.elementAt(index);
            //             return GestureDetector(
            //               onTap: () => navigateToDetails(anime),
            //               child: Container(
            //                 width: 160,
            //                 margin: EdgeInsets.symmetric(horizontal: 4.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Image.network(
            //                       anime.imageUrl,
            //                       height: 200,
            //                       fit: BoxFit.cover,
            //                     ),
            //                     SizedBox(height: 4),
            //                     Text(
            //                       anime.title,
            //                       style: TextStyle(fontSize: 16, color: Colors.white),
            //                       overflow: TextOverflow.ellipsis,
            //                       maxLines: 1,
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text(
            //                           'Dob | Sub', style: TextStyle(fontSize: 14, color: Colors.grey),
            //                         ),
            //                         IconButton(
            //                           icon: Icon(Icons.more_vert, color: Colors.grey),
            //                           onPressed: () {
            //                             // More options
            //                           },
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         );
            //       }
            //     },
            //   ),
            // ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoDemo()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(16.0),
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Kimetsu_no_Yaiba-cover.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Row(
                        children: [
                          Icon(Icons.play_circle_fill, color: Colors.white, size: 40,),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anime Title',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Temporada 1, Episodio 1',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Text(
                        '15 min restantes',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () => showModal(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
