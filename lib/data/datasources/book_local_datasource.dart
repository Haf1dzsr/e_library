import 'package:e_library/data/helper/database_helper.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:sqflite/sqflite.dart';

class BookLocalDatasource {
  static final BookLocalDatasource instance = BookLocalDatasource._internal();

  factory BookLocalDatasource() {
    return instance;
  }

  BookLocalDatasource._internal();

  Future<int> insertBook(BookModel book) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('books', book.toMap());
  }

  Future<List<BookModel>> getBooks() async {
    Database db = await DatabaseHelper.instance.database;
    return (await db.query('books'))
        .map((book) => BookModel.fromMap(book))
        .toList();
  }

  Future<BookModel> getBook(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> books =
        await db.query('books', where: 'id = ?', whereArgs: [id]);
    return BookModel.fromMap(books.first);
  }

  Future<int> updateBook(BookModel book, int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db
        .update('books', book.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBook(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
