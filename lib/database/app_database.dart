import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'movies.db';
  final String tableName = 'favorite_movies';

  Database? _db;

  Future<Database> openDb() async {
    _db = await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version) {
      String query = 'create table $tableName (id integer primay key)';
      log(query);
      database.execute(query);
    }, version: version);
    return _db as Database;
  }
}
