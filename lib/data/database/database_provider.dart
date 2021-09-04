import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final favoriteTable = 'favorite';

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "db_restaurant.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $favoriteTable ("
        "id TEXT PRIMARY KEY,"
        "name TEXT, "
        "description TEXT, "
        "image TEXT, "
        "city TEXT, "
        "rating TEXT "
        ")");
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
}
