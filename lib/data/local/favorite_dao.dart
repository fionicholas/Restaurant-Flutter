import 'package:restaurant_app/data/database/database_provider.dart';
import 'package:restaurant_app/data/model/favorite_entity.dart';

class FavoriteDao {
  final dbProvider = DatabaseHelper();

  Future<int> addToFavorite(FavoriteEntity favoriteEntity) async {
    final db = await dbProvider.database;
    var result = db!.insert(favoriteTable, favoriteEntity.toDatabaseJson());
    return result;
  }

  Future<List<FavoriteEntity>> getFavorites({String? query}) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    if (query != null && query != '') {
      if (query.isNotEmpty)
        result = await db!.query(favoriteTable,
            where: 'name LIKE ?', whereArgs: ["%$query%"]);
    } else {
      result = await db!.query(favoriteTable, orderBy: 'id DESC');
    }

    List<FavoriteEntity> favorites = result.isNotEmpty
        ? result.map((item) => FavoriteEntity.fromDatabaseJson(item)).toList()
        : [];
    return favorites;
  }

  Future<int> deleteFavorite(String id) async {
    final db = await dbProvider.database;
    var result = db!.delete(favoriteTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<FavoriteEntity> checkFavoriteById({required String id}) async {
    final db = await dbProvider.database;
    var result =
        await db!.query(favoriteTable, where: 'id = ?', whereArgs: [id]);

    List<FavoriteEntity> favorite = result.isNotEmpty
        ? result.map((data) => FavoriteEntity.fromDatabaseJson(data)).toList()
        : [];

    FavoriteEntity favoriteEntity = favorite[0];

    return favoriteEntity;
  }
}
