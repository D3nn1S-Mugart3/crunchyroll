// models/anime.dart
class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['node']['id'],
      title: json['node']['title'],
      imageUrl: json['node']['main_picture']['medium'],
      synopsis: json['node']['synopsis'] ?? 'No synopsis available',
    );
  }
}