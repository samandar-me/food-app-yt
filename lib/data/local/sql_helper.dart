import 'package:food_app_yt/data/model/food_response.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    database.execute("""
      CRATE TABLE foods(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL
      )
    """);
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "food.db",
      version: 1,
      onCreate: (sql.Database database, int version1) async {
        return createTable(database);
      }
    );
  }
  Future<void> saveFood(Results results) async {
    final db = await SqlHelper.db();
    await db.insert('foods', results.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}