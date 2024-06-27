import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/services/api_service.dart';
import 'package:crunchyroll/page/view/home/scroll_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _scrollOffset = 0;
  late Future<Iterable<Anime>> _futureAnimes;
  late Future<Iterable<Anime>> _futurePopularAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = getAnimeByRankingTypeApi(rankingType: 'all', limit: 10);
    _futurePopularAnimes = getAnimeByRankingTypeApi(rankingType: 'bypopularity', limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), 
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
              stops: const [0.5, 0.6, 0.7, 0.3]
            ),
          ),
          child: AppBar(
            backgroundColor: _scrollOffset  > 200 ? Colors.black : Colors.transparent,
            elevation: 0,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
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
              child: ScrollHomePage(futureAnimes: _futureAnimes, futurePopularAnimes: _futurePopularAnimes),
            )
          ),
        ],
      )
    );
  }
}