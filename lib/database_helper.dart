import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:prova2/eletro.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bd.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE eletro(id INTEGER PRIMARY KEY,marca TEXT, modelo TEXT, cor TEXT, preco TEXT)');
  }

  Future<int> inserirEletro(Eletro eletro) async {
    var dbClient = await db;
    var result = await dbClient.insert("eletro", eletro.toMap());
    return result;
  }

  Future<List> getEletros() async {
    var dbClient = await db;
    var result = await dbClient
        .query("eletro", columns: ["id", "marca", "modelo", "cor", "preco"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM eletro'));
  }

  Future<Eletro> getEletro(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("eletro",
        columns: ["id", "marca", "modelo", "cor", "preco"],
        where: 'ide = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Eletro.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteEletro(int id) async {
    var dbClient = await db;
    return await dbClient.delete("eletro", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateEletro(Eletro eletro) async {
    var dbClient = await db;
    return await dbClient.update("eletro", eletro.toMap(),
        where: "id = ?", whereArgs: [eletro.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
