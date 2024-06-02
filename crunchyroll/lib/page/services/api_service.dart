// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

Future<Iterable<Anime>> getAnimeByRankingTypeApi({
  required String rankingType,
  required int limit,
}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';

  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': 'f4b43c14393b157005dee233e1ea0661',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> animeNodeList = data['data'];
    final animes = animeNodeList
        .where((animeNode) => animeNode['node']['main_picture'] != null)
        .map((node) {
          return Anime.fromJson(node);
        });

    return animes;
  } else {
    throw Exception("Failed to get data!");
  }
}
