import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_apps/app/data/news_bookmark_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'news_bookmark_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE news_bookmarks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        author TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      )
    ''');
  }

  Future<int> insertNewsBookmark(NewsBookmark newsBookmark) async {
    Database db = await instance.database;
    return await db.insert('news_bookmarks', newsBookmark.toMap());
  }

  Future<List<NewsBookmark>> getAllNewsBookmarks() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('news_bookmarks');
    return List.generate(maps.length, (i) {
      return NewsBookmark.fromMap(maps[i]);
    });
  }

  Future<void> deleteNewsBookmark(int id) async {
    Database db = await instance.database;
    await db.delete('news_bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isArticleBookmarked(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'news_bookmarks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
