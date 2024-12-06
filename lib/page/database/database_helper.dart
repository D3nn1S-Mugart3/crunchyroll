import 'dart:async';
import 'dart:io';
import 'package:crunchyroll/page/models/anime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY,
            title TEXT,
            imageUrl TEXT,
            synopsis TEXT
          )
        ''');
      },
    );
  }

  Future<int> addFavorite(Anime anime) async {
    final db = await database;
    try {
      // Verifica si ya existe en favoritos
      final existingAnime = await db.query(
        'favorites',
        where: 'id = ?',
        whereArgs: [anime.id],
      );

      if (existingAnime.isNotEmpty) {
        print('El anime ya está en favoritos.');
        return 0; // No se inserta un duplicado
      }

      // Descarga la imagen localmente
      final localImagePath = await _downloadImage(anime.imageUrl);

      // Inserta los datos en la base de datos
      return await db.insert('favorites', {
        'id': anime.id,
        'title': anime.title,
        'imageUrl': localImagePath,
        'synopsis': anime.synopsis,
      });
    } catch (e) {
      print('Error al guardar anime: $e');
      rethrow;
    }
  }

  Future<List<Anime>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    print('Favoritos recuperados: ${maps.length}');

    return List.generate(maps.length, (i) {
      return Anime(
        id: maps[i]['id'],
        title: maps[i]['title'],
        imageUrl: maps[i]['imageUrl'],
        synopsis: maps[i]['synopsis'],
      );
    });
  }

  Future<int> removeFavorite(int id) async {
    final db = await database;
    final anime = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    if (anime.isNotEmpty) {
      final imagePath = anime.first['imageUrl'] as String;
      final file = File(imagePath);

      try {
        if (await file.exists()) {
          await file.delete(); // Elimina la imagen local
        }
      } catch (e) {
        print('Error al eliminar la imagen: $e');
      }
    }
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<String> _downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Obtén el directorio de almacenamiento local
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Guarda la imagen localmente
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return filePath; // Devuelve la ruta del archivo guardado
      } else {
        throw Exception('Error al descargar la imagen: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al descargar la imagen: $e');
    }
  }
}
