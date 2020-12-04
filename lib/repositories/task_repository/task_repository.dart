import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class TaskRepository {
  static const String DB_NAME = 'todos.db';

  Future<Database> database() async {
    //first we create a data base if we don't have one
    final dbPath = await getDatabasesPath();
    //it will open existing data base or otherwise will create data base with specified name
    return openDatabase(path.join(dbPath, DB_NAME), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todos(id TEXT PRIMARY KEY, task TEXT, isDone INT)');
    }, version: 1);
  }

  Future<List<Map<String, dynamic>>> getTask(String table,
      {String collectionId}) async {
    final db = await database();
    return db.query(table);
  }

  Future<void> insertTask(String table, Map<String, Object> data) async {
    //if table is created it's created with specified table structure
    //where's ID is a Primary key,

    // sql.ConflictAlgorithm.replace if the entry already exists, it will override it
    final db = await database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(String table, Map<String, Object> data) async {
    //if table is created it's created with specified table structure
    //where's ID is a Primary key,

    // sql.ConflictAlgorithm.replace if the entry already exists, it will override it
    final db = await database();
    db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delteTask(String table, String id) async {
    final db = await database();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
