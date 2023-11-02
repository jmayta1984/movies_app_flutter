import 'package:movies_app_flutter/database/app_database.dart';

class FavoriteMovieRepository {
  Future<List<int>> getAll() async {
    final db = await AppDatabase().openDb();
    final List maps = await db.query(AppDatabase().tableName);
    final ids = maps.map((map) => map['id'] as int).toList();
    return ids;
  }

  Future<bool> isFavorite(int id) async {
    final db = await AppDatabase().openDb();
    final List maps =
        await db.query(AppDatabase().tableName, where: 'id=?', whereArgs: [id]);
    return maps.isNotEmpty;
  }

  insert(int id) async {
    final db = await AppDatabase().openDb();
    await db.insert(AppDatabase().tableName, {'id': id});
  }

  delete(int id) async {
    final db = await AppDatabase().openDb();
    await db.delete(AppDatabase().tableName, where: 'id=?', whereArgs: [id]);
  }
}
