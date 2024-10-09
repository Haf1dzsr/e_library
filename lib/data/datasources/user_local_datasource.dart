import 'package:e_library/data/helper/database_helper.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  static final UserLocalDataSource instance = UserLocalDataSource._internal();

  factory UserLocalDataSource() {
    return instance;
  }

  UserLocalDataSource._internal();

  Future<int> insertUser(UserModel user) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query('users');
  }

  Future<UserModel?> getUser() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> users = await db.query('users');
    if (users.isEmpty) {
      return null;
    } else {
      return UserModel.fromMap(users.first);
    }
  }

  Future<int> updateUserPhoto(String photo, int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('users', {'photo': photo},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(UserModel user, int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
