import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'e-library.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        photo TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_file TEXT,
        book_cover TEXT,
        title TEXT,
        author TEXT,
        genre TEXT,
        page_total INTEGER,
        synopsis TEXT,
        published_year INTEGER,
        is_favorited INTEGER
      )
    ''');
  }

  Future<void> clearUsersTable() async {
    Database db = await instance.database;
    await db.delete('users');
  }

  Future<void> clearBooksTable() async {
    Database db = await instance.database;
    await db.delete('books');
  }
}
