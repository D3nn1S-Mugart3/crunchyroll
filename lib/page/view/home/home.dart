import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/routes/anime_detail_page.dart';
import 'package:crunchyroll/page/routes/video_anime.dart';
import 'package:crunchyroll/page/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home_Page2 extends StatefulWidget {
  const Home_Page2({super.key});

  @override
  State<Home_Page2> createState() => _Home_Page2State();
}

class _Home_Page2State extends State<Home_Page2> {
  double _scrollOffset = 0;
  bool isAddedToList = false;
  late Future<Iterable<Anime>> _futureAnimes;
  late Future<Iterable<Anime>> _futurePopularAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = getAnimeByRankingTypeApi(rankingType: 'all', limit: 10);
    _futurePopularAnimes = getAnimeByRankingTypeApi(rankingType: 'bypopularity', limit: 10);
  }

  void toggleListStatus() {
    setState(() {
      isAddedToList = !isAddedToList;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text(
              isAddedToList ? 'Añadida a Favoritos' : 'Eliminado de Favoritos',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
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
                Colors.black12,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.6, 0.7, 0.3]
            ),
          ),
          child: AppBar(
            backgroundColor: _scrollOffset  > 200 ? Colors.black : Colors.transparent,
            elevation: 0,
            title: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _scrollOffset > 200 ? 1.0 : 0.0,
            ),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  setState(() {
                    _scrollOffset = scrollNotification.metrics.pixels;
                  });
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.6,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://m.media-amazon.com/images/I/61Zm2hsRJ0L._AC_SY879_.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Estamos en la era de Taisho de Japón. Tanjiro, un joven que se gana la vida vendiendo carbón, descubre un día que su familia ha sido asesinada por un demonio...',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.play_arrow_outlined, size: 35, color: Colors.black,),
                              label: Text(
                                'COMENZAR A VER E1', 
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[900],
                                fixedSize: Size(160, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Espacio entre los botones
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromARGB(255, 230, 81, 0)),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.transparent,
                            ),
                            child: IconButton(
                              onPressed: toggleListStatus,
                              icon: Icon(isAddedToList ? Icons.bookmark : Icons.bookmark_border, color: Colors.orange[900]),
                              color: Colors.orange[900],
                              iconSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'NUESTRAS RECOMENDACIONES',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<Iterable<Anime>>(
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
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          // Acción al hacer clic en la miniatura
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoDemo(),
                            ),
                          );
                        },
                        child: Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                              image: NetworkImage('https://m.media-amazon.com/images/I/61Zm2hsRJ0L._AC_SY879_.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Row(
                                  children: [
                                    Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nombre del Video',
                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Capítulo 1',
                                          style: TextStyle(color: Colors.white, fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton(
                                  icon: Icon(Icons.more_vert, color: Colors.white),
                                  onPressed: () => showModal(context),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Text(
                                  '5:00',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'VIDEOS MUSICALES AHORA EN CRUNCHYROLL MUSIC',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<Iterable<Anime>>(
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
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}