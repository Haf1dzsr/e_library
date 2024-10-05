import 'package:e_library/data/models/user_model.dart';
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
    String path = join(await getDatabasesPath(), 'users.db');

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
  }

  Future<int> insertUser(UserModel user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  Future<Map<String, dynamic>> getUser(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> users =
        await db.query('users', where: 'id = ?', whereArgs: [id]);
    return users.first;
  }

  Future<int> updateUser(Map<String, dynamic> user, int id) async {
    Database db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearProjectTable() async {
    Database db = await instance.database;
    await db.delete('users');
  }
}
