import 'package:sqflite/sqflite.dart';

class BlogRepo {
  void createTable(Database? db) {
    db?.execute(
        'CREATE TABLE IF NOT EXISTS BLOG(id INTEGER PRIMARY KEY, title TEXT, image_url TEXT)');
  }

  Future<List> getBlogs(Database? db) async {
    final List<Map<String, dynamic>> maps = await db!.query('Blog');
    return maps;
  }
}
