import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
class DatabaseHelper{
  // 工厂模式
  factory DatabaseHelper() =>_getInstance();
  static DatabaseHelper get instance => _getInstance();
  static DatabaseHelper _instance;
  final String tableName = "table_picture";
  final String columnId = "id";
  final String columnName = "name";
  final String columnAge = "age";

  DatabaseHelper._internal() {
    // 初始化
  }
  static DatabaseHelper _getInstance() {
    if (_instance == null) {
      _instance = new DatabaseHelper._internal();
    }
    return _instance;
  }
  static Database _db;

  Future<Database> get db async{
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'picture.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
        "create table $tableName($columnId integer primary key,$columnName text not null ,$columnAge integer not null )");
    print("Table is created");
  }


}