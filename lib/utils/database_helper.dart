import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "wc_app.db";
  static final _databaseVersion = 1;

  static final prayerTable = 'prayers';

  static final prayerId = '_id';
  static final prayerTitle = 'title';
  static final prayerCategory = 'category';
  static final prayerRequest = 'requestId';

  static final requestTable = 'requests';

  static final requestId = '_id';
  static final requestCreated = 'created';
  static final requestLastEdited = 'lastEdited';
  static final requestCompleted = 'completed';
  static final requestContent = 'content';
  static final requestPrayCount = 'prayCount';
  static final requestIsStarred = 'isStarred';
  static final requestIsActive = 'isActive';

  static final lookupTable = 'lookup';

  static final lookupId = '_id';
  static final lookupPrayerId = 'prayerId';
  static final lookupRequestId = 'requestId';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //       DROP TABLE IF EXISTS $prayerTable
    //      ''');
    // await db.execute('''
    //       DROP TABLE IF EXISTS $lookupTable
    //      ''');
    // await db.execute('''
    //       DROP TABLE IF EXISTS $requestTable
    //      ''');
    await db.execute('''
          CREATE TABLE $prayerTable (
            $prayerId INTEGER PRIMARY KEY,
            $prayerTitle TEXT NOT NULL,
            $prayerCategory INTEGER,
            $prayerRequest INTEGER
          )
         ''');
    await db.execute('''
          CREATE TABLE $lookupTable (
            $lookupId INTEGER PRIMARY KEY,
            $lookupPrayerId INTEGER NOT NULL,
            $lookupRequestId INTEGER NOT NULL
          )
         ''');
    await db.execute('''
          CREATE TABLE $requestTable (
            $requestId INTEGER PRIMARY KEY,
            $requestCreated TEXT NOT NULL,
            $requestLastEdited TEXT,
            $requestCompleted TEXT,
            $requestContent TEXT NOT NULL,
            $requestPrayCount INTEGER NOT NULL,
            $requestIsStarred INTEGER NOT NULL,
            $requestIsActive INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[prayerId];
    return await db.update(table, row, where: '$prayerId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$prayerId = ?', whereArgs: [id]);
  }

  Future reset(String table) async {
    Database db = await instance.database;
    await db.execute('''
          DROP TABLE IF EXISTS $prayerTable
         ''');
    await db.execute('''
          DROP TABLE IF EXISTS $lookupTable
         ''');
    await db.execute('''
          DROP TABLE IF EXISTS $requestTable
         ''');
    await _onCreate(db, _databaseVersion);
  }

  Future<List<Map<String, dynamic>>> getResult(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT
        requests._id AS reqId,
        created,
        lastEdited,
        completed,
        content,
        prayCount,
        isStarred,
        isActive
      FROM
        requests
      INNER JOIN lookup ON lookup.requestId = reqId
      WHERE
        lookup.prayerId = $id;
    ''');
  }
}
