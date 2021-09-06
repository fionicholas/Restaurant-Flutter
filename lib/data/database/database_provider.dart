import 'package:sqflite/sqflite.dart';

final favoriteTable = 'favorite';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $favoriteTable ("
            "id TEXT PRIMARY KEY,"
            "name TEXT, "
            "description TEXT, "
            "image TEXT, "
            "city TEXT, "
            "rating TEXT "
            ")");
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }
}
