import 'package:crunchyroll/page/models/anime.dart';
import 'package:crunchyroll/page/view/home/big_image.dart';
import 'package:crunchyroll/page/view/home/double_button.dart';
import 'package:crunchyroll/page/view/home/music_video.dart';
import 'package:crunchyroll/page/view/home/recommendation.dart';
import 'package:crunchyroll/page/view/home/video_thumbnail.dart';
import 'package:flutter/material.dart';

class ScrollHomePage extends StatelessWidget {
  const ScrollHomePage({
    super.key,
    required Future<Iterable<Anime>> futureAnimes,
    required Future<Iterable<Anime>> futurePopularAnimes,
  }) : _futureAnimes = futureAnimes, _futurePopularAnimes = futurePopularAnimes;

  final Future<Iterable<Anime>> _futureAnimes;
  final Future<Iterable<Anime>> _futurePopularAnimes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BigImage(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Estamos en la era de Taisho de Japón. Tanjiro, un joven que se gana la vida vendiendo carbón, descubre un día que su familia ha sido asesinada por un demonio...',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          const DoubleButton(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'NUESTRAS RECOMENDACIONES',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          const SizedBox(height: 10),
          Recommendations(futureAnimes: _futureAnimes),
          const SizedBox(height: 15),
          const VideoThumbnail(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'VIDEOS MUSICALES AHORA EN CRUNCHYROLL MUSIC',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          const SizedBox(height: 10),
          MusicVideo(futurePopularAnimes: _futurePopularAnimes),
        ],
      ),
    );
  }
}