import 'package:flutter/material.dart';

class AnimeDetailPage extends StatelessWidget {
  final String animeName = "One Piece";
  final String seriesInfo = "Series ";
  final String seriesInfoDob = "• Dob | Sub";
  final String availability = "Disponibilidad de subtítulos en Latinoamérica: Domingos a la 1:30 AM PST (Fora del pacifico) ...";
  final String details = "DETALLES DE LA SERIE";
  final String episodeSyncInfo = "Episodios sincronizados";
  final String syncedEpisodes = "5 Episodios";
  final String storageInfo = "1.2 GB";
  final String seasonInfo = "Temporada 1";
  final List<Map<String, String>> episodes = [
    {"thumbnail": "assets/images/alicization.png", "title": "Capítulo 1", "name": "El comienzo"},
    {"thumbnail": "assets/images/one-piece.jpg", "title": "Capítulo 2", "name": "La aventura continúa"},
    {"thumbnail": "assets/images/Kimetsu_no_Yaiba-cover.jpg", "title": "Capítulo 2", "name": "La aventura continúa"},
    {"thumbnail": "assets/images/alicization.png", "title": "Capítulo 2", "name": "La aventura continúa"},
    {"thumbnail": "assets/images/alicization.png", "title": "Capítulo 2", "name": "La aventura continúa"},
    {"thumbnail": "assets/images/alicization.png", "title": "Capítulo 2", "name": "La aventura continúa"},
    {"thumbnail": "assets/images/alicization.png", "title": "Capítulo 2", "name": "La aventura continúa"},
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
              background: Image.asset(
                "assets/images/one-piece.jpg",
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
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        seriesInfo,
                        style: TextStyle(color: const Color.fromARGB(255, 33, 243, 236), fontSize: 16),
                      ),
                      Text(
                        seriesInfoDob,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.add, color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "AÑADIR A CRUNCHYLISTA",
                        style: TextStyle(color: Colors.white)
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    availability,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 14),
                  Center(
                    child: Text(
                      details,
                      style: TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        episodeSyncInfo,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "$syncedEpisodes • $storageInfo",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    seasonInfo,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
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
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode["title"]!,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  episode["name"]!,
                                  style: TextStyle(color: Colors.white54, fontSize: 14),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.check_circle, color: Colors.green),
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
