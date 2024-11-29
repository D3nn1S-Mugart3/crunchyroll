import 'dart:async';
import 'package:crunchyroll/page/models/anime.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      final result = await db.insert('favorites', {
        'id': anime.id,
        'title': anime.title,
        'imageUrl': anime.imageUrl,
        'synopsis': anime.synopsis,
      });

      if (result != -1) {
        print('Anime guardado: ${anime.title}');
      } else {
        print('Error al guardar anime: Ya existe en favoritos.');
      }

      return result;
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
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int id) async {
    final db = await database;
    final result =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
